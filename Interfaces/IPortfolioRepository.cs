using NexTrade.Dtos.Portfolio;
using NexTrade.Models;

namespace NexTrade.Interfaces
{
    public interface IPortfolioRepository
    {
        Task<List<StockModel>> GetUserPortfolio(UserModel user);

        Task<PortfolioModel> CreateAsync(PortfolioModel portfolio);

        Task<PortfolioModel> DeletePortfolio(UserModel user, string symbol);

        Task<List<StockPortfolioDto>> GetUserPortfolioStock(UserModel user);
    }
}
