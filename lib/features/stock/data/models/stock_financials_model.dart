import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';

class StockFinancialsModel extends StockFinancials {
  StockFinancialsModel({
    super.balanceSheet,
    super.cashFlow,
    super.dividendsSplits,
    super.generalInfo,
    super.incomeStatement,
    super.riskGovernance,
    super.shareholderHoldings,
    super.valuation,
  });

  factory StockFinancialsModel.fromJson(Map<String, dynamic> map) {
    return StockFinancialsModel(
      balanceSheet: map['balanceSheet'] != null
          ? BalanceSheetModel.fromJson(map['balanceSheet'])
          : null,
      cashFlow: map['cashFlow'] != null
          ? CashFlowModel.fromJson(map['cashFlow'])
          : null,
      dividendsSplits: map['dividendsSplits'] != null
          ? DividendsSplitsModel.fromJson(map['dividendsSplits'])
          : null,
      generalInfo: map['generalInfo'] != null
          ? GeneralInfoModel.fromJson(map['generalInfo'])
          : null,
      incomeStatement: map['incomeStatement'] != null
          ? IncomeStatementModel.fromJson(map['incomeStatement'])
          : null,
      riskGovernance: map['riskGovernance'] != null
          ? RiskGovernanceModel.fromJson(map['riskGovernance'])
          : null,
      shareholderHoldings: map['shareholderHoldings'] != null
          ? ShareholderHoldingsModel.fromJson(map['shareholderHoldings'])
          : null,
      valuation: map['valuation'] != null
          ? ValuationModel.fromJson(map['valuation'])
          : null,
    );
  }
}

class BalanceSheetModel extends BalanceSheet {
  BalanceSheetModel({
    super.bookValuePerShare,
    super.cashAndCashEquivalents,
    super.debtToEquityRatio,
    super.netDebt,
    super.otherShortTermInvestments,
    super.totalAssets,
    super.totalDebt,
    super.totalLiabilities,
  });

  factory BalanceSheetModel.fromJson(Map<String, dynamic> map) {
    return BalanceSheetModel(
      bookValuePerShare: (map['bookValuePerShare'] as num?)?.toDouble(),
      cashAndCashEquivalents: map['cashAndCashEquivalents'] as int?,
      debtToEquityRatio: (map['debtToEquityRatio'] as num?)?.toDouble(),
      netDebt: (map['netDebt'] as num?)?.toDouble(),
      otherShortTermInvestments: (map['otherShortTermInvestments']  as num?)?.toDouble(),
      totalAssets: (map['totalAssets']  as num?)?.toDouble(),
      totalDebt: map['totalDebt'] as int?,
      totalLiabilities: map['totalLiabilities'] as int?,
    );
  }
}

class CashFlowModel extends CashFlow {
  CashFlowModel({
    super.capitalExpenditures,
    super.freeCashFlow,
    super.totalCashFlowFromOperations,
  });

  factory CashFlowModel.fromJson(Map<String, dynamic> map) {
    return CashFlowModel(
      capitalExpenditures: map['capitalExpenditures'] as int?,
      freeCashFlow: map['freeCashFlow'] as int?,
      totalCashFlowFromOperations: map['totalCashFlowFromOperations'] as int?,
    );
  }
}

class DividendsSplitsModel extends DividendsSplits {
  DividendsSplitsModel({
    super.dividendDate,
    super.lastDividendPaid,
    super.lastStockSplitDate,
    super.lastStockSplitRatio,
  });

  factory DividendsSplitsModel.fromJson(Map<String, dynamic> map) {
    return DividendsSplitsModel(
      dividendDate: map['dividendDate'] as int?,
      lastDividendPaid: (map['lastDividendPaid'] as num?)?.toDouble(),
      lastStockSplitDate: map['lastStockSplitDate'] as int?,
      lastStockSplitRatio: map['lastStockSplitRatio'] as String?,
    );
  }
}

class GeneralInfoModel extends GeneralInfo {
  GeneralInfoModel({
    super.averageVolume10Days,
    super.beta,
    super.companyName,
    super.currency,
    super.currentPrice,
    super.dayHigh,
    super.dayLow,
    super.enterpriseValue,
    super.exchange,
    super.fiftyTwoWeekHigh,
    super.fiftyTwoWeekLow,
    super.marketCap,
    super.openPrice,
    super.previousClosePrice,
    super.sharesOutstanding,
  });

  factory GeneralInfoModel.fromJson(Map<String, dynamic> map) {
    return GeneralInfoModel(
      averageVolume10Days: map['averageVolume10Days'] as int?,
      beta: (map['beta'] as num?)?.toDouble(),
      companyName: map['companyName'] as String?,
      currency: map['currency'] as String?,
      currentPrice: (map['currentPrice'] as num?)?.toDouble(),
      dayHigh: (map['dayHigh'] as num?)?.toDouble(),
      dayLow: (map['dayLow'] as num?)?.toDouble(),
      enterpriseValue: map['enterpriseValue'] as int?,
      exchange: map['exchange'] as String?,
      fiftyTwoWeekHigh: (map['fiftyTwoWeekHigh'] as num?)?.toDouble(),
      fiftyTwoWeekLow: (map['fiftyTwoWeekLow'] as num?)?.toDouble(),
      marketCap: map['marketCap'] as int?,
      openPrice: (map['openPrice'] as num?)?.toDouble(),
      previousClosePrice: (map['previousClosePrice'] as num?)?.toDouble(),
      sharesOutstanding: map['sharesOutstanding'] as int?,
    );
  }
}

class IncomeStatementModel extends IncomeStatement {
  IncomeStatementModel({
    super.costOfRevenue,
    super.ebitda,
    super.ebitdaMargins,
    super.grossProfit,
    super.netIncome,
    super.operatingIncome,
    super.operatingMargins,
    super.profitMargins,
    super.revenueGrowth,
    super.totalRevenue,
  });

  factory IncomeStatementModel.fromJson(Map<String, dynamic> map) {
    return IncomeStatementModel(
      costOfRevenue: map['costOfRevenue'] as int?,
      ebitda: map['ebitda'] as int?,
      ebitdaMargins: (map['ebitdaMargins'] as num?)?.toDouble(),
      grossProfit: map['grossProfit'] as int?,
      netIncome: (map['netIncome']  as num?)?.toDouble(),
      operatingIncome: (map['operatingIncome'] as num?)?.toDouble(),
      operatingMargins: (map['operatingMargins'] as num?)?.toDouble(),
      profitMargins: (map['profitMargins'] as num?)?.toDouble(),
      revenueGrowth: (map['revenueGrowth'] as num?)?.toDouble(),
      totalRevenue: map['totalRevenue'] as int?,
    );
  }
}

class RiskGovernanceModel extends RiskGovernance {
  RiskGovernanceModel({
    super.auditRisk,
    super.boardRisk,
    super.compensationRisk,
    super.overallRiskScore,
    super.shareholderRightsRisk,
  });

  factory RiskGovernanceModel.fromJson(Map<String, dynamic> map) {
    return RiskGovernanceModel(
      auditRisk: map['auditRisk'] as int?,
      boardRisk: map['boardRisk'] as int?,
      compensationRisk: map['compensationRisk'] as int?,
      overallRiskScore: map['overallRiskScore'] as int?,
      shareholderRightsRisk: map['shareholderRightsRisk'] as int?,
    );
  }
}

class ShareholderHoldingsModel extends ShareholderHoldings {
  ShareholderHoldingsModel({
    super.floatShares,
    super.heldByInsiders,
    super.heldByInstitutions,
    super.treasurySharesNumber,
  });

  factory ShareholderHoldingsModel.fromJson(Map<String, dynamic> map) {
    return ShareholderHoldingsModel(
      floatShares: map['floatShares'] as int?,
      heldByInsiders: (map['heldByInsiders'] as num?)?.toDouble(),
      heldByInstitutions: (map['heldByInstitutions'] as num?)?.toDouble(),
      treasurySharesNumber: (map['treasurySharesNumber'] as num?)?.toDouble(),
    );
  }
}

class ValuationModel extends Valuation {
  ValuationModel({
    super.enterpriseValueToEBITDA,
    super.enterpriseValueToRevenue,
    super.forwardPERatio,
    super.priceToBookRatio,
    super.priceToSalesRatio,
    super.trailingPERatio,
  });

  factory ValuationModel.fromJson(Map<String, dynamic> map) {
    return ValuationModel(
      enterpriseValueToEBITDA: (map['enterpriseValueToEBITDA'] as num?)?.toDouble(),
      enterpriseValueToRevenue: (map['enterpriseValueToRevenue'] as num?)?.toDouble(),
      forwardPERatio: (map['forwardPERatio'] as num?)?.toDouble(),
      priceToBookRatio: (map['priceToBookRatio'] as num?)?.toDouble(),
      priceToSalesRatio: (map['priceToSalesRatio'] as num?)?.toDouble(),
      trailingPERatio: (map['trailingPERatio'] as num?)?.toDouble(),
    );
  }
}



