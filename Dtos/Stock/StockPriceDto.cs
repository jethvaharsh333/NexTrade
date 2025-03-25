namespace NexTrade.Dtos.Stock
{
    public class StockPriceDto
    {
        // The dto/model will be automatically map to JSON data camelCase word. HERE, its "date".
        public string Date { get; set; }

        public decimal Close { get; set; }

        public decimal High { get; set; }

        public decimal Low { get; set; }

        public decimal Open { get; set; }

        public decimal Volume { get; set; }
    }
}
