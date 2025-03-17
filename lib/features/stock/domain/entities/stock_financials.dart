class StockFinancials {
  final BalanceSheet? balanceSheet;
  final CashFlow? cashFlow;
  final DividendsSplits? dividendsSplits;
  final GeneralInfo? generalInfo;
  final IncomeStatement? incomeStatement;
  final RiskGovernance? riskGovernance;
  final ShareholderHoldings? shareholderHoldings;
  final Valuation? valuation;

  StockFinancials({
    this.balanceSheet,
    this.cashFlow,
    this.dividendsSplits,
    this.generalInfo,
    this.incomeStatement,
    this.riskGovernance,
    this.shareholderHoldings,
    this.valuation,
  });
}

class BalanceSheet {
  final double? bookValuePerShare;
  final int? cashAndCashEquivalents;
  final double? debtToEquityRatio;
  final double? netDebt;
  final double? otherShortTermInvestments;
  final double? totalAssets;
  final int? totalDebt;
  final int? totalLiabilities; // MAY OCCUR ERROR

  BalanceSheet({
    this.bookValuePerShare,
    this.cashAndCashEquivalents,
    this.debtToEquityRatio,
    this.netDebt,
    this.otherShortTermInvestments,
    this.totalAssets,
    this.totalDebt,
    this.totalLiabilities,
  });
}

class CashFlow {
  final int? capitalExpenditures;// MAY OCCUR ERROR
  final int? freeCashFlow;// MAY OCCUR ERROR
  final int? totalCashFlowFromOperations;// MAY OCCUR ERROR

  CashFlow({
    this.capitalExpenditures,
    this.freeCashFlow,
    this.totalCashFlowFromOperations,
  });
}

class DividendsSplits {
  final int? dividendDate;
  final double? lastDividendPaid;
  final int? lastStockSplitDate;
  final String? lastStockSplitRatio;

  DividendsSplits({
    this.dividendDate,
    this.lastDividendPaid,
    this.lastStockSplitDate,
    this.lastStockSplitRatio,
  });
}

class GeneralInfo {
  final int? averageVolume10Days;
  final double? beta;
  final String? companyName;
  final String? currency;
  final double? currentPrice;
  final double? dayHigh;
  final double? dayLow;
  final int? enterpriseValue;
  final String? exchange;
  final double? fiftyTwoWeekHigh;
  final double? fiftyTwoWeekLow;
  final int? marketCap;
  final double? openPrice;
  final double? previousClosePrice;
  final int? sharesOutstanding;

  GeneralInfo({
    this.averageVolume10Days,
    this.beta,
    this.companyName,
    this.currency,
    this.currentPrice,
    this.dayHigh,
    this.dayLow,
    this.enterpriseValue,
    this.exchange,
    this.fiftyTwoWeekHigh,
    this.fiftyTwoWeekLow,
    this.marketCap,
    this.openPrice,
    this.previousClosePrice,
    this.sharesOutstanding,
  });
}

class IncomeStatement {
  final int? costOfRevenue;   // MAY OCCUR ERROR
  final int? ebitda;
  final double? ebitdaMargins;
  final int? grossProfit;
  final double? netIncome;
  final double? operatingIncome;
  final double? operatingMargins;
  final double? profitMargins;
  final double? revenueGrowth;
  final int? totalRevenue;

  IncomeStatement({
    this.costOfRevenue,
    this.ebitda,
    this.ebitdaMargins,
    this.grossProfit,
    this.netIncome,
    this.operatingIncome,
    this.operatingMargins,
    this.profitMargins,
    this.revenueGrowth,
    this.totalRevenue,
  });
}

class RiskGovernance {
  final int? auditRisk;// MAY OCCUR ERROR
  final int? boardRisk;// MAY OCCUR ERROR
  final int? compensationRisk;// MAY OCCUR ERROR
  final int? overallRiskScore;// MAY OCCUR ERROR
  final int? shareholderRightsRisk;// MAY OCCUR ERROR

  RiskGovernance({
    this.auditRisk,
    this.boardRisk,
    this.compensationRisk,
    this.overallRiskScore,
    this.shareholderRightsRisk,
  });
}

class ShareholderHoldings {
  final int? floatShares;
  final double? heldByInsiders;
  final double? heldByInstitutions;
  final double? treasurySharesNumber;// MAY OCCUR ERROR

  ShareholderHoldings({
    this.floatShares,
    this.heldByInsiders,
    this.heldByInstitutions,
    this.treasurySharesNumber,
  });
}

class Valuation {
  final double? enterpriseValueToEBITDA;
  final double? enterpriseValueToRevenue;
  final double? forwardPERatio;// MAY OCCUR ERROR
  final double? priceToBookRatio;
  final double? priceToSalesRatio;
  final double? trailingPERatio;

  Valuation({
    this.enterpriseValueToEBITDA,
    this.enterpriseValueToRevenue,
    this.forwardPERatio,
    this.priceToBookRatio,
    this.priceToSalesRatio,
    this.trailingPERatio,
  });
}
