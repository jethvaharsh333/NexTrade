using NexTrade.Dtos.Comment;

namespace NexTrade.Dtos.Stock
{
    public class StockListDto
    {
        public string StockName { get; set; } = string.Empty;

        public string StockSymbol { get; set; } = string.Empty;

        public int FaceValue { get; set; }

        public string? StockImage { get; set; } = string.Empty;

        public string? Industry { get; set; } = string.Empty;

    }
}
