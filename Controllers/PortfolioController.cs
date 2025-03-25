using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Query;
using NexTrade.Dtos.Portfolio;
using NexTrade.Extensions;
using NexTrade.Interfaces;
using NexTrade.Interfaces.Portfolio;
using NexTrade.Interfaces.Stock;
using NexTrade.Models;
using NexTrade.Repository;

namespace NexTrade.Controllers
{
    [Route("api/portfolio")]
    [ApiController]
    public class PortfolioController : ControllerBase
    {
        private readonly UserManager<UserModel> _userManager;
        private readonly IStockRepository _stockRepository;
        private readonly IPortfolioRepository _portfolioRepository;
        private readonly IPortfolioService _portfolioService;
        public PortfolioController(UserManager<UserModel> userManager, IStockRepository stockRepository, IPortfolioRepository portfolioRepository, IPortfolioService portfolioService)
        {
            _userManager = userManager;
            _stockRepository = stockRepository;
            _portfolioRepository = portfolioRepository;
            _portfolioService = portfolioService;
        }

        [HttpGet]
        [Authorize]
        public async Task<IActionResult> GetUserPortfolio() 
        {
            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);
            var userPortfolioStocks = await _portfolioRepository.GetUserPortfolio(appUser);

            return Ok(userPortfolioStocks);
        }


        [HttpGet("get-user-stocks-in-portfolio")]
        [Authorize]
        public async Task<IActionResult> GetUserStocksInPortfolio()
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);

                if (appUser == null)
                    return Unauthorized(new { message = "User not found" });

                var userPortfolioStocks = await _portfolioRepository.GetUserPortfolioStock(appUser);
                if (userPortfolioStocks == null || !userPortfolioStocks.Any())
                    return Ok("null");

                List<string> listOfCompanies = userPortfolioStocks.Select(u => u.StockSymbol+".NS").ToList();

                var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
                if (string.IsNullOrEmpty(token))
                    return Unauthorized(new { message = "Missing Authorization token" });

                var flaskStockData = await _portfolioService.GetStockPriceFromFlaskAsync(token, listOfCompanies);
                if (flaskStockData == null)
                    return StatusCode(500, new { message = "Failed to fetch stock data from Flask" });

                double totalInvestmentPrice = 0;
                double totalCurrentValue = 0;

                var portfolioResult = userPortfolioStocks.Select(s =>
                {
                    var flaskData = flaskStockData.FirstOrDefault(f => f.StockSymbol == s.StockSymbol+".NS");

                    double currentPrice = (double)flaskData.CurrentPrice;

                    double investmentPrice = s.InvestmentPrice * s.Quantity;
                    double currentStockValue = currentPrice * s.Quantity;

                    // Update total values
                    totalInvestmentPrice += investmentPrice;
                    totalCurrentValue += currentStockValue;

                    return new StockPortfolioDto
                    {
                        StockSymbol = s.StockSymbol,
                        StockName = s.StockName,
                        InvestmentDate = s.InvestmentDate,
                        InvestmentPrice = s.InvestmentPrice,
                        Quantity = s.Quantity,
                        CurrentPrice = currentPrice,
                        TodaysGainLoss = (double)((flaskData?.OpenPrice ?? 0) - (flaskData?.CurrentPrice ?? 0)),
                        AbsoluteGainLoss = ((double)(flaskData?.CurrentPrice ?? 0) - s.InvestmentPrice) * s.Quantity,
                    };
                }).ToList();

                double totalGainLoss = totalCurrentValue - totalInvestmentPrice;
                
                

                return Ok(new
                {
                    Portfolio = portfolioResult,
                    Summary = new
                    {
                        TotalInvestment = totalInvestmentPrice,
                        TotalCurrentValue = totalCurrentValue,
                        TotalGainLoss = totalGainLoss
                    }
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in GetUserStocksInPortfolio: {ex.Message}");
                return StatusCode(500, new { message = "An error occurred", error = ex.Message });
            }
        }

        [HttpPost("add-stock-to-portfolio")]
        [Authorize]
        public async Task<IActionResult> AddStockToPortfolio([FromBody] AddPortfolio addPortfolio)
        {
            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            if(appUser == null)
            {
                return BadRequest("User not found.");
            }

            var stock = await _stockRepository.GetBySymbolAsync(addPortfolio.StockSymbol);

            if(stock == null)
            {
                return BadRequest("Stock not found.");
            }

            var userPortfolio = await _portfolioRepository.GetUserPortfolio(appUser);

            Console.WriteLine("USERPORTFOLIO: \n" + userPortfolio);

            if (userPortfolio.Any(e => e.StockSymbol.ToLower() == addPortfolio.StockSymbol.ToLower()))
            {
                return BadRequest("Cannot add same stock to portfolio.");
            }

            var portfolioModel = new PortfolioModel {
                InvestmentDate = addPortfolio.InvestmentDate,
                InvestmentPrice = addPortfolio.InvestmentPrice,
                Quantity = addPortfolio.Quantity,
                UserID = appUser.Id,
                StockID = stock.StockID,
                AddedAt = DateTime.Now,
            };

            await _portfolioRepository.CreateAsync(portfolioModel);

            if(portfolioModel == null)
            {
                return StatusCode(500, "Could not create.");
            }
            else
            {
                return Created();
            }
        }

        [HttpDelete("delete-stock-in-portfolio")]
        [Authorize]
        public async Task<IActionResult> DeleteStockInPortfolio(string symbol)
        {
            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);

            var userPortfolios = await _portfolioRepository.GetUserPortfolio(appUser);
            
            var filteredStock = userPortfolios.Where(s => s.StockSymbol.ToLower() == symbol.ToLower()).ToList();

            if(filteredStock.Count() == 1)
            {
                await _portfolioRepository.DeletePortfolio(appUser, symbol);
            }
            else
            {
                return BadRequest("Stock not in your portfolio.");
            }

            return Ok();

        }
    }
}
