namespace NexTrade.Dtos.Stock
{
    public class StockIndex
    {
        public string IndexName { get; set; }
        public double? PercentageChange { get; set; }
        public double? PriceChange { get; set; }
    }
}
