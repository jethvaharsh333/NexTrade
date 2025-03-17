namespace NexTrade.Dtos.Portfolio
{
    public class StockPortfolioDto
    {
        public string StockSymbol { get; set; }

        public string StockName { get; set; }

        public DateTime InvestmentDate { get; set; }

        public double InvestmentPrice { get; set; }

        public double Quantity { get; set; }

        public double CurrentPrice { get; set; }

        public double TodaysGainLoss { get; set; }   //OpenPrice-CurrentPrice

        public double AbsoluteGainLoss { get; set; }    //(CurrentPrice-InvestmentPrice)*Quantity
    }

    public class StockOpenCurrentPriceDto
    {
        public string StockSymbol { get; set; }
        public decimal OpenPrice { get; set; }
        public decimal CurrentPrice { get; set; }
    }
}
