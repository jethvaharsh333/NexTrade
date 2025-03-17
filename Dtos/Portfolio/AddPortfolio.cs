namespace NexTrade.Dtos.Portfolio
{
    public class AddPortfolio
    {
        public String StockSymbol { get; set; }

        public DateTime InvestmentDate { get; set; }

        public double InvestmentPrice { get; set; }

        public double Quantity { get; set; }
    }
}
