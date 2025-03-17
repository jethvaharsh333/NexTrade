using NexTrade.Models;

namespace NexTrade.Interfaces
{
    public interface IWatchlistRepository
    {
        Task<bool> IsStockExistInWatchlistAsync(string userId, string stockSymbol);
        Task<WatchlistModel> CreateAsync(WatchlistModel watchlistModel);
        Task<List<StockModel>> GetWatchlistStocksAsync(UserModel user);
        Task<WatchlistModel?> GetWatchListByIDAsync(int id);
        Task<WatchlistModel?> GetWatchlistStockByIDAndUserAsync(string userId, string stockSymbol);
        Task<bool> DeleteAsync(WatchlistModel watchlistStock);
    }
}
