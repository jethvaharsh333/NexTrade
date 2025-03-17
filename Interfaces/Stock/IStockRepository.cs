using NexTrade.Dtos.Stock;
using NexTrade.Models;

namespace NexTrade.Interfaces.Stock
{
    public interface IStockRepository
    {
        Task<List<StockModel>> GetAllAsync(int page, int pageSize);
        Task<StockModel?> GetByIDAsync(int id);

        //Task<StockModel> CreateAsync(CreateStockRequestDto creatStockDto);
        Task<StockModel> CreateAsync(StockModel stockModel);
        Task<StockModel?> UpdateAsync(int id, UpdateStockRequestDto updateStockDto);
        Task<StockModel?> DeleteAsync(int id);
        Task<bool> IsStockExist(string stockSymbol);
        Task<StockModel?> GetBySymbolAsync(string symbol);

        //Task<StockModel> GetStockPriceBySymbolAsync(string stockSymbol);
    }
}
