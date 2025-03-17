using Newtonsoft.Json;
using System;

namespace NexTrade.Dtos.Stock
{
    public class StockFinancialDto
    {
        public BalanceSheet BalanceSheet { get; set; }
        public CashFlow CashFlow { get; set; }
        public DividendsSplits DividendsSplits { get; set; }
        public GeneralInfo GeneralInfo { get; set; }
        public IncomeStatement IncomeStatement { get; set; }
        public RiskGovernance RiskGovernance { get; set; }
        public ShareholderHoldings ShareholderHoldings { get; set; }
        public Valuation Valuation { get; set; }
    }

    public class BalanceSheet
    {
        public double? BookValuePerShare { get; set; }
        public long? CashAndCashEquivalents { get; set; }
        public double? DebtToEquityRatio { get; set; }
        public double?   NetDebt { get; set; }
        public double? OtherShortTermInvestments { get; set; }
        public double? TotalAssets { get; set; }
        public long? TotalDebt { get; set; }
        public double? TotalLiabilities { get; set; }
    }

    public class CashFlow
    {
        public double? CapitalExpenditures { get; set; }
        public double? FreeCashFlow { get; set; }
        public double? TotalCashFlowFromOperations { get; set; }
    }

    public class DividendsSplits
    {
        public long? DividendDate { get; set; }
        public double? LastDividendPaid { get; set; }
        public long? LastStockSplitDate { get; set; }
        public string? LastStockSplitRatio { get; set; }
    }

    public class GeneralInfo
    {
        public long? AverageVolume10Days { get; set; }
        public double? Beta { get; set; }
        public string? CompanyName { get; set; }
        public string? Currency { get; set; }
        public double? CurrentPrice { get; set; }
        public double? DayHigh { get; set; }
        public double? DayLow { get; set; }
        public long? EnterpriseValue { get; set; }
        public string? Exchange { get; set; }
        public double? FiftyTwoWeekHigh { get; set; }
        public double? FiftyTwoWeekLow { get; set; }
        public long? MarketCap { get; set; }
        public double? OpenPrice { get; set; }
        public double? PreviousClosePrice { get; set; }
        public long? SharesOutstanding { get; set; }
    }

    public class IncomeStatement
    {
        public double? CostOfRevenue { get; set; }
        public long? EBITDA { get; set; }
        public double? EbitdaMargins { get; set; }
        public long? GrossProfit { get; set; }
        public double? NetIncome { get; set; }
        public double? OperatingIncome { get; set; }
        public double? OperatingMargins { get; set; }
        public double? ProfitMargins { get; set; }
        public double? RevenueGrowth { get; set; }
        public long? TotalRevenue { get; set; }
    }

    public class RiskGovernance
    {
        public int? AuditRisk { get; set; }
        public int? BoardRisk { get; set; }
        public int? CompensationRisk { get; set; }
        public int? OverallRiskScore { get; set; }
        public int? ShareholderRightsRisk { get; set; }
    }

    public class ShareholderHoldings
    {
        public long? FloatShares { get; set; }
        public double? HeldByInsiders { get; set; }
        public double? HeldByInstitutions { get; set; }
        public double? TreasurySharesNumber { get; set; } // Using nullable for NaN values
    }

    public class Valuation
    {
        public double? EnterpriseValueToEBITDA { get; set; }
        public double? EnterpriseValueToRevenue { get; set; }
        public double? ForwardPERatio { get; set; }
        public double? PriceToBookRatio { get; set; }
        public double? PriceToSalesRatio { get; set; }
        public double?  TrailingPERatio { get; set; }
    }

    //public class GeneralInfoDto
    //{
    //    public double? fiftyTwoWeekHigh { get; set; }

    //    public double? fiftyTwoWeekLow { get; set; }

    //    public long? averageVolume10Days { get; set; }

    //    public double? beta { get; set; }

    //    public string companyName { get; set; }

    //    public string currency { get; set; }

    //    public double? currentPrice { get; set; }

    //    public double? dayHigh { get; set; }

    //    public double? dayLow { get; set; }

    //    public long? enterpriseValue { get; set; }

    //    public string exchange { get; set; }

    //    public long? marketCap { get; set; }

    //    public double? openPrice { get; set; }

    //    public double? previousClose { get; set; }

    //    public long? sharesOutstanding { get; set; }
    //}

    //public class IncomeStatementDto
    //{
    //    [JsonProperty("Cost of Revenue")]
    //    public double? CostOfRevenue { get; set; }

    //    [JsonProperty("EBITDA")]
    //    public long? EBITDA { get; set; }

    //    [JsonProperty("EBITDA Margins")]
    //    public double? EBITDA_Margins { get; set; }

    //    [JsonProperty("Gross Profit")]
    //    public long? GrossProfit { get; set; }

    //    [JsonProperty("Net Income")]
    //    public double? NetIncome { get; set; }

    //    [JsonProperty("Operating Income")]
    //    public double? OperatingIncome { get; set; }

    //    [JsonProperty("Operating Margins")]
    //    public double? OperatingMargins { get; set; }

    //    [JsonProperty("Profit Margins")]
    //    public double? ProfitMargins { get; set; }

    //    [JsonProperty("Revenue Growth")]
    //    public double? RevenueGrowth { get; set; }

    //    [JsonProperty("Total Revenue")]
    //    public long? TotalRevenue { get; set; }
    //}

    //public class BalanceSheetDto
    //{
    //    [JsonProperty("Book Value Per Share")]
    //    public double? BookValuePerShare { get; set; }

    //    [JsonProperty("Cash & Cash Equivalents")]
    //    public long? CashAndCashEquivalents { get; set; }

    //    [JsonProperty("Debt-to-Equity Ratio")]
    //    public double? DebtToEquityRatio { get; set; }

    //    [JsonProperty("Net Debt")]
    //    public double? NetDebt { get; set; }

    //    [JsonProperty("Other Short-Term Investments")]
    //    public double? OtherShortTermInvestments { get; set; }

    //    [JsonProperty("Total Assets")]
    //    public double? TotalAssets { get; set; }

    //    [JsonProperty("Total Debt")]
    //    public long? TotalDebt { get; set; }

    //    [JsonProperty("Total Liabilities")]
    //    public double? TotalLiabilities { get; set; }
    //}

    //public class ValuationDto
    //{
    //    [JsonProperty("Enterprise Value to EBITDA")]
    //    public double? EnterpriseValueToEBITDA { get; set; }

    //    [JsonProperty("Enterprise Value to Revenue")]
    //    public double? EnterpriseValueToRevenue { get; set; }

    //    [JsonProperty("Forward P/E Ratio")]
    //    public double? ForwardPE { get; set; }

    //    [JsonProperty("Price-to-Book Ratio (P/B)")]
    //    public double? PriceToBook { get; set; }

    //    [JsonProperty("Price-to-Sales Ratio (P/S)")]
    //    public double? PriceToSales { get; set; }

    //    [JsonProperty("Trailing P/E Ratio")]
    //    public double? TrailingPE { get; set; }
    //}

    //public class CashFlowDto
    //{
    //    [JsonProperty("Capital Expenditures (CapEx)")]
    //    public double? CapitalExpenditures { get; set; }

    //    [JsonProperty("Free Cash Flow (FCF)")]
    //    public double? FreeCashFlow { get; set; }

    //    [JsonProperty("Total Cash Flow from Operations")]
    //    public double? TotalCashFlowFromOperations { get; set; }
    //}

    //public class RiskGovernanceDto
    //{
    //    [JsonProperty("Audit Risk")]
    //    public int? AuditRisk { get; set; }

    //    [JsonProperty("Board Risk")]
    //    public int? BoardRisk { get; set; }

    //    [JsonProperty("Compensation Risk")]
    //    public int? CompensationRisk { get; set; }

    //    [JsonProperty("Overall Risk Score")]
    //    public int? OverallRiskScore { get; set; }

    //    [JsonProperty("Shareholder Rights Risk")]
    //    public int? ShareholderRightsRisk { get; set; }
    //}

    //public class ShareholderHoldingsDto
    //{
    //    [JsonProperty("Float Shares")]
    //    public long? FloatShares { get; set; }

    //    [JsonProperty("Held by Insiders (%)")]
    //    public double? HeldByInsiders { get; set; }

    //    [JsonProperty("Held by Institutions (%)")]
    //    public double? HeldByInstitutions { get; set; }

    //    [JsonProperty("Treasury Shares Number")]
    //    public double? TreasurySharesNumber { get; set; }
    //}

    //public class DividendsSplitsDto
    //{
    //    [JsonProperty("Dividend Date")]
    //    public long? LastDividendDate { get; set; }

    //    [JsonProperty("Last Dividend Paid")]
    //    public double? LastDividendPaid { get; set; }

    //    [JsonProperty("Last Stock Split Date")]
    //    public long? LastStockSplitDate { get; set; }

    //    [JsonProperty("Last Stock Split Ratio")]
    //    public string LastStockSplitRatio { get; set; }
    //}
}

//{
//    "Balance Sheet": {
//        "Book Value Per Share": 3.767,
//    "Cash & Cash Equivalents": 65171001344,
//    "Debt-to-Equity Ratio": 209.059,
//    "Net Debt": 76686000000.0,
//    "Other Short-Term Investments": 35228000000.0,
//    "Total Assets": 364980000000.0,
//    "Total Debt": 119058997248,
//    "Total Liabilities": null
//    },
//  "Cash Flow": {
//        "Capital Expenditures (CapEx)": null,
//    "Free Cash Flow (FCF)": null,
//    "Total Cash Flow from Operations": null
//  },
//  "Dividends Splits": {
//        "Dividend Date": 1739145600,
//    "Last Dividend Paid": 0.25,
//    "Last Stock Split Date": 1598832000,
//    "Last Stock Split Ratio": "4:1"
//  },
//  "General Info": {
//        "52-Week High": 260.1,
//    "52-Week Low": 164.08,
//    "Average Volume (10 Days)": 53842610,
//    "Beta": 1.24,
//    "Company Name": "Apple Inc.",
//    "Currency": "USD",
//    "Current Price": 232.62,
//    "Day High": 235.23,
//    "Day Low": 228.13,
//    "Enterprise Value": 3645256499200,
//    "Exchange": "NMS",
//    "Market Cap": 3494440861696,
//    "Open Price": 228.2,
//    "Previous Close Price": 227.65,
//    "Shares Outstanding": 15022100480
//  },
//  "Income Statement": {
//        "Cost of Revenue": null,
//    "EBITDA": 134660997120,
//    "EBITDA Margins": 0.34437,
//    "Gross Profit": 180682997760,
//    "Net Income": 93736000000.0,
//    "Operating Income": 123216000000.0,
//    "Operating Margins": 0.31171,
//    "Profit Margins": 0.23971,
//    "Revenue Growth": 0.061,
//    "Total Revenue": 391034994688
//  },
//  "Risk Governance": {
//        "Audit Risk": 3,
//    "Board Risk": 1,
//    "Compensation Risk": 3,
//    "Overall Risk Score": 1,
//    "Shareholder Rights Risk": 1
//  },
//  "Shareholder Holdings": {
//        "Float Shares": 15091184209,
//    "Held by Insiders (%)": 0.020669999,
//    "Held by Institutions (%)": 0.62310004,
//    "Treasury Shares Number": NaN
//  },
//  "Valuation": {
//        "Enterprise Value to EBITDA": 27.07,
//    "Enterprise Value to Revenue": 9.322,
//    "Forward P/E Ratio": 28.204977,
//    "Price-to-Book Ratio (P/B)": 61.752056,
//    "Price-to-Sales Ratio (P/S)": 8.936389,
//    "Trailing P/E Ratio": 36.86529
//  }
//}