namespace NexTrade.Dtos.Stock
{
    public class UpdateStockRequestDto
    {
        public string StockName { get; set; } = string.Empty;

        public string StockSymbol { get; set; } = string.Empty;

        public string? StockImage { get; set; } = string.Empty;

        public string? Industry { get; set; } = string.Empty;
        
        public DateTime DateOfListing { get; set; }
        
        public int FaceValue { get; set; }
    }
}
