using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using NexTrade.Dtos.Portfolio;
using NexTrade.Dtos.Watchlist;
using NexTrade.Extensions;
using NexTrade.Interfaces;
using NexTrade.Interfaces.Portfolio;
using NexTrade.Interfaces.Stock;
using NexTrade.Mappers;
using NexTrade.Models;

namespace NexTrade.Controllers
{
    [Route("api/watchlist")]
    [ApiController]
    public class WatchlistController : ControllerBase
    {
        private readonly UserManager<UserModel> _userManager;
        private readonly IStockRepository _stockRepository;
        private readonly IWatchlistRepository _watchlistRepository;
        private readonly IPortfolioService _portfolioService;
        public WatchlistController(UserManager<UserModel> userManager, IStockRepository stockRepository, IWatchlistRepository watchlistRepository, IPortfolioService portfolioService)
        {
            _userManager = userManager;
            _stockRepository = stockRepository;
            _watchlistRepository = watchlistRepository;
            _portfolioService = portfolioService;
        }

        [HttpGet("get-watchlist-stocks")]
        [Authorize]
        public async Task<IActionResult> GetWatchlistStocks()
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);
                if (appUser == null)
                    return Unauthorized(new { message = "User not found" });

                var watchlistStocks = await _watchlistRepository.GetWatchlistStocksAsync(appUser);
                //if (watchlistStocks == null || !watchlistStocks.Any())
                //    return NotFound(new { message = "No stocks found in watchlist" });

                List<string> listOfCompanies = watchlistStocks.Select(u => u.StockSymbol).ToList();

                return Ok(listOfCompanies);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("get-watchlist-stocks-with-finance")]
        [Authorize]
        public async Task<IActionResult> GetWatchlistStocksWithFinance()
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);
                if (appUser == null)
                    return Unauthorized(new { message = "User not found" });

                var watchlistStocks = await _watchlistRepository.GetWatchlistStocksAsync(appUser);
                //if (watchlistStocks == null || !watchlistStocks.Any())
                //    return NotFound(new { message = "No stocks found in watchlist" });

                List<string> listOfCompanies = watchlistStocks.Select(u => u.StockSymbol + ".NS").ToList();

                var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
                if (string.IsNullOrEmpty(token))
                    return Unauthorized(new { message = "Missing Authorization token" });

                var flaskStockData = await _portfolioService.GetStockPriceFromFlaskAsync(token, listOfCompanies);
                if (flaskStockData == null)
                    return StatusCode(500, new { message = "Failed to fetch stock data from Flask" });

                var watchlistResult = watchlistStocks.Select(w =>
                {
                    var flaskData = flaskStockData.FirstOrDefault(f => f.StockSymbol == w.StockSymbol + ".NS");
                    return new WatchlistStockDataDto
                    {
                        StockSymbol = w.StockSymbol,
                        StockName = w.StockName,
                        FaceValue = w.FaceValue,
                        Industry = w.Industry,
                        StockImage = w.StockImage,
                        CurrentPrice = (double)flaskData.CurrentPrice,
                        TodaysGainLoss = (double)((flaskData?.OpenPrice ?? 0) - (flaskData?.CurrentPrice ?? 0)),
                    };
                }).ToList();

                return Ok(watchlistResult);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in GetUserStocksInPortfolio: {ex.Message}");
                return StatusCode(500, new { message = "An error occurred", error = ex.Message });
            }
        }

        [HttpGet("{id}")]
        [Authorize]
        public async Task<IActionResult> GetById([FromRoute] int id)
        {
            var watchlistStock = await _watchlistRepository.GetWatchListByIDAsync(id);

            if (watchlistStock == null)
            {
                return NotFound();
            }

            return Ok(watchlistStock);
        }

        //[HttpPost("{stockSymbol}")]
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> AddStockToWatchlist([FromBody] AddPortfolio addPortfolio)
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);
                if (appUser == null)
                    return Unauthorized(new { message = "User not found" });

                var stock = await _stockRepository.GetBySymbolAsync(addPortfolio.StockSymbol);
                if (stock == null)
                    return BadRequest(new { message = "Stock not found" });

                if (await _watchlistRepository.IsStockExistInWatchlistAsync(appUser.Id, addPortfolio.StockSymbol))
                {
                    return BadRequest(new { message = "Stock already in watchlist" });
                }

                var watchlist = new WatchlistModel
                {
                    StockID = stock.StockID,
                    UserID = appUser.Id
                };

                var model = await _watchlistRepository.CreateAsync(watchlist);

                if (model == null)
                    return StatusCode(500, new { message = "Could not create" });

                return Ok(model);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in AddStockToWatchlist: {ex.Message}");
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpDelete("remove/{stockSymbol}")]
        [Authorize]
        public async Task<IActionResult> RemoveStockFromWatchlist([FromRoute] string stockSymbol)
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);
                if (appUser == null)
                    return Unauthorized(new { message = "User not found" });

                var stock = await _stockRepository.GetBySymbolAsync(stockSymbol);
                if (stock == null)
                    return NotFound(new { message = "Stock not found" });

                var watchlistEntry = await _watchlistRepository.GetWatchlistStockByIDAndUserAsync(appUser.Id, stockSymbol);
                if (watchlistEntry == null)
                    return NotFound(new { message = "Stock not in watchlist" });

                var result = await _watchlistRepository.DeleteAsync(watchlistEntry);
                if (!result)
                    return StatusCode(500, new { message = "Could not remove stock from watchlist" });

                return Ok(new { message = "Stock removed successfully" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in RemoveStockFromWatchlist: {ex.Message}");
                return StatusCode(500, new { message = "An error occurred", error = ex.Message });
            }
        }
    }
}
