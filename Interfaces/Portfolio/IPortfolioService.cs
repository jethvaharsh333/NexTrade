using NexTrade.Dtos.Portfolio;

namespace NexTrade.Interfaces.Portfolio
{
    public interface IPortfolioService
    {
        Task<List<StockOpenCurrentPriceDto>> GetStockPriceFromFlaskAsync(string token, List<string> symbol);
    }
}
