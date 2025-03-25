using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json.Linq;
using NexTrade.Dtos.Stock;

namespace NexTrade.Interfaces.Stock
{
    public interface IStockService
    {
        Task<List<StockPriceDto>> GetStockPriceAsync(string token, string stockSymbol, string period);

        Task<StockFinancialDto> GetStockFinancialAsync(string token, string stockSymbol);

        Task<StockFinancialChecksDto> GetStockFinancialCheckAsync(string token, string stockSymbol);
        Task<List<StockIndex>> GetStockIndicesAsync(string token);



        //Task<AllowAnonymousAttribute> GetStock 
    }
}
