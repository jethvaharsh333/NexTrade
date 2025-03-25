using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using NexTrade.Data;
using NexTrade.Dtos.Stock;
using NexTrade.Interfaces.Stock;
using NexTrade.Models;
using NexTrade.Service;

namespace NexTrade.Repository
{
    public class StockRepository: IStockRepository, IStockService
    {
        private readonly ApplicationDBContext _context;
        private readonly FlaskService _flaskService;

        public StockRepository(ApplicationDBContext context, FlaskService flaskService)
        {
            _context = context;
            _flaskService = flaskService;
        }

        public async Task<List<StockModel>> GetAllAsync(int page, int pageSize)
        {
            //return await _context.Stocks.Include(c => c.Comments).ThenInclude(u => u.User).ToListAsync();
            //return await _context.Stocks.ToListAsync();
            return await _context.Stocks
                    .Skip((page - 1) * pageSize)
                    .Take(pageSize)
                    .ToListAsync();
        }

        public async Task<StockModel?> GetByIDAsync(int id)
        {
            return await _context.Stocks.Include(c => c.Comments).FirstOrDefaultAsync(stock => stock.StockID == id);
        }
        
        public async Task<StockModel> CreateAsync(StockModel stockModel)
        {
            await _context.Stocks.AddAsync(stockModel);
            await _context.SaveChangesAsync();
            return stockModel;
        }

        public async Task<StockModel?> UpdateAsync(int id, UpdateStockRequestDto updateStockDto)
        {
            var existingStock = await _context.Stocks.FirstOrDefaultAsync(x => x.StockID == id);

            if (existingStock == null)
            {
                return null;
            }

            existingStock.StockSymbol = updateStockDto.StockSymbol;
            existingStock.StockName = updateStockDto.StockName;
            existingStock.StockImage = updateStockDto.StockImage;
            existingStock.Industry = updateStockDto.Industry;
            existingStock.DateOfListing = updateStockDto.DateOfListing;
            existingStock.FaceValue = updateStockDto.FaceValue;

            await _context.SaveChangesAsync();
            return existingStock;
        }

        public async Task<StockModel?> DeleteAsync(int id)
        {
            var stockModel = await _context.Stocks.FirstOrDefaultAsync(stock => stock.StockID == id);

            if (stockModel == null)
            {
                return null;
            }

            _context.Stocks.Remove(stockModel);
            await _context.SaveChangesAsync();

            return stockModel;
        }

        public async Task<bool> IsStockExist(string stockSymbol)
        {
            return await _context.Stocks.AnyAsync(s => s.StockSymbol == stockSymbol);
        }

        public async Task<StockModel?> GetBySymbolAsync(string symbol)
        {
            return await _context.Stocks.FirstOrDefaultAsync(s => s.StockSymbol == symbol);
        }

        public async Task<List<StockPriceDto>> GetStockPriceAsync(string token, string stockSymbol, string period)
        {
            return await _flaskService.GetStockPriceFromFlaskAsync(token, stockSymbol, period); 
        }

        public async Task<StockFinancialDto> GetStockFinancialAsync(string token, string stockSymbol)
        {
            return await _flaskService.GetStockFinancialFromFlaskAsync(token, stockSymbol);
        }

        public async Task<StockFinancialChecksDto> GetStockFinancialCheckAsync(string token, string stockSymbol)
        {
            return await _flaskService.GetStockFinancialChecksFromFlaskAsync(token, stockSymbol);
        }

        public async Task<List<StockIndex>> GetStockIndicesAsync(string token)
        {
            return await _flaskService.GetStockIndicesFromFlaskAsync(token);
        }
    }
}
