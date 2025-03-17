using Microsoft.EntityFrameworkCore;
using NexTrade.Data;
using NexTrade.Interfaces;
using NexTrade.Models;

namespace NexTrade.Repository
{
    public class WatchlistRepository: IWatchlistRepository
    {
        private readonly ApplicationDBContext _context;
        public WatchlistRepository(ApplicationDBContext context)
        {
            _context = context;
        }

        public async Task<WatchlistModel> CreateAsync(WatchlistModel watchlistModel)
        {
            await _context.Watchlists.AddAsync(watchlistModel);
            await _context.SaveChangesAsync();
            return watchlistModel;
        }

        public async Task<WatchlistModel?> GetWatchListByIDAsync(int id)
        {
            return await _context.Watchlists.Include(s => s.User).Include(s=>s.Stock).FirstOrDefaultAsync(w => w.WatchlistID == id);
        }

        public async Task<WatchlistModel?> GetWatchlistStockByIDAndUserAsync(string userId, string stockSymbol)
        {
            return await _context.Watchlists.FirstOrDefaultAsync(w => w.UserID == userId && w.Stock.StockSymbol == stockSymbol);
        }

        public async Task<List<StockModel>> GetWatchlistStocksAsync(UserModel user)
        {
            return await _context.Watchlists.Where(u => u.UserID == user.Id)
                .Select(stock => new StockModel
                {
                    StockID = stock.Stock.StockID,
                    StockSymbol = stock.Stock.StockSymbol,
                    StockName = stock.Stock.StockName,
                    StockImage = stock.Stock.StockImage,
                    DateOfListing = stock.Stock.DateOfListing,
                    FaceValue = stock.Stock.FaceValue
                })
                .ToListAsync();
        }

        public async Task<bool> IsStockExistInWatchlistAsync(string id, string stockSymbol)
        {
            var stock = await _context.Watchlists.FirstOrDefaultAsync(s => s.Stock.StockSymbol == stockSymbol && s.User.Id == id);

            if(stock == null)
            {
                return false;
            }

            return true;
        }

        public async Task<bool> DeleteAsync(WatchlistModel watchlistStock)
        {
            _context.Watchlists.Remove(watchlistStock);
            return await _context.SaveChangesAsync() > 0;
        }
    }
}
