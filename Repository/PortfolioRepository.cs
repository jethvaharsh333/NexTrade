using Microsoft.EntityFrameworkCore;
using NexTrade.Data;
using NexTrade.Dtos.Portfolio;
using NexTrade.Interfaces;
using NexTrade.Interfaces.Portfolio;
using NexTrade.Models;
using NexTrade.Service;

namespace NexTrade.Repository
{
    public class PortfolioRepository : IPortfolioRepository, IPortfolioService
    {
        private readonly ApplicationDBContext _context;
        private readonly FlaskService _flaskService;
        public PortfolioRepository(ApplicationDBContext context, FlaskService flaskService) 
        {
            _context = context;
            _flaskService = flaskService;
        }

        public async Task<List<StockModel>> GetUserPortfolio(UserModel user)
        {
            return await _context.Portfolios.Where(u => u.UserID == user.Id)
                .Select(stock => new StockModel
                {
                    StockID = stock.StockID,
                    StockSymbol = stock.Stock.StockSymbol,
                    StockName = stock.Stock.StockName,
                    StockImage = stock.Stock.StockImage,
                    DateOfListing = stock.Stock.DateOfListing,
                    FaceValue = stock.Stock.FaceValue
                })
                .ToListAsync();
        }

        public async Task<List<StockPortfolioDto>> GetUserPortfolioStock(UserModel user)
        {
            return await _context.Portfolios.Where(u => u.UserID == user.Id)
                .Select(s => new StockPortfolioDto
                {
                    StockSymbol = s.Stock.StockSymbol,
                    StockName = s.Stock.StockName,
                    InvestmentDate = s.InvestmentDate,
                    InvestmentPrice = s.InvestmentPrice,
                    Quantity = s.Quantity,
                })
                .ToListAsync();
        }

        public async Task<PortfolioModel> CreateAsync(PortfolioModel portfolio)
        {
            await _context.Portfolios.AddAsync(portfolio);
            await _context.SaveChangesAsync();
            return portfolio;
        }

        public async Task<PortfolioModel> DeletePortfolio(UserModel user, string symbol)
        {
            var portfolioModel = await _context.Portfolios.FirstOrDefaultAsync(x => x.UserID == user.Id  &&  x.Stock.StockSymbol.ToLower() == symbol.ToLower());

            if (portfolioModel == null) {
                return null;
            }

            _context.Portfolios.Remove(portfolioModel);
            await _context.SaveChangesAsync();

            return portfolioModel;
        }

        public async Task<List<StockOpenCurrentPriceDto>> GetStockPriceFromFlaskAsync(string token, List<string> symbols)
        {
            return await _flaskService.GetStockOpenCurrentPriceFromFlaskAsync(token, symbols);
        }
    }
}
