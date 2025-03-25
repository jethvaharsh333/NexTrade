using Newtonsoft.Json;

namespace NexTrade.Dtos.Stock
{
    public class StockFinancialChecksDto
    {
        public string DebtRiskCheck { get; set; }

        public string InvestmentDecision { get; set; }

        public string InvestorConfidenceCheck { get; set; }

        public string LiquidityCheck { get; set; }

        public string ProfitabilityCheck { get; set; }

        public string RevenueGrowthCheck { get; set; }

        public string ValuationCheck { get; set; }

        public string VolatilityCheck { get; set; }
    }
}