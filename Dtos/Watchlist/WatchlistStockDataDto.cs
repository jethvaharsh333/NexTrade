namespace NexTrade.Dtos.Watchlist
{
    public class WatchlistStockDataDto
    {
        public string StockSymbol { get; set; }
        public string StockName { get; set; }
        public int FaceValue { get; set; }
        public string? StockImage { get; set; } = string.Empty;
        public string? Industry { get; set; } = string.Empty;
        public double CurrentPrice { get; set; }
        public double TodaysGainLoss { get; set; }
    }
}
