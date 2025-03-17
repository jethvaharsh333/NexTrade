import 'package:flutter/material.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';

class StockFinancialsCards extends StatelessWidget {
  final StockFinancials stockFinancials;

  const StockFinancialsCards({super.key, required this.stockFinancials});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGeneralInfoCard(),
        _buildBalanceSheetCard(),
        _buildCashFlowCard(),
        _buildIncomeStatementCard(),
        _buildDividendsSplitsCard(),
        _buildRiskGovernanceCard(),
        _buildShareholderHoldingsCard(),
        _buildValuationCard(),
      ],
    );
  }

  Widget _buildGeneralInfoCard() {
    final generalInfo = stockFinancials.generalInfo;
    if (generalInfo == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'General Info',
      iconData: Icons.info_outline,
      gradientColors: [Color(0xFF181820), // Dark background base
        Color(0xFF1A1B28), // Slightly lighter dark shade
        Color(0xFF1F8A70),  ],
      items: [
        // KeyValueItem(key: 'Company Name', value: generalInfo.companyName),
        KeyValueItem(key: 'Current Price', value: generalInfo.currentPrice),
        KeyValueItem(key: 'Market Cap', value: generalInfo.marketCap),
        KeyValueItem(key: 'Exchange', value: generalInfo.exchange),
        KeyValueItem(key: 'Currency', value: generalInfo.currency),
        KeyValueItem(key: 'Beta', value: generalInfo.beta),
        KeyValueItem(key: '52 Week High', value: generalInfo.fiftyTwoWeekHigh),
        KeyValueItem(key: '52 Week Low', value: generalInfo.fiftyTwoWeekLow),
        KeyValueItem(key: 'Shares Outstanding', value: generalInfo.sharesOutstanding),
      ],
    );
  }

  Widget _buildBalanceSheetCard() {
    final balanceSheet = stockFinancials.balanceSheet;
    if (balanceSheet == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Balance Sheet',
      iconData: Icons.balance_outlined,
      gradientColors: [Color(0xFF2D2E40), Color(0xFF1A1B28)],
      items: [
        KeyValueItem(key: 'Book Value Per Share', value: balanceSheet.bookValuePerShare),
        KeyValueItem(key: 'Cash & Equivalents', value: balanceSheet.cashAndCashEquivalents),
        KeyValueItem(key: 'Debt to Equity', value: balanceSheet.debtToEquityRatio),
        KeyValueItem(key: 'Net Debt', value: balanceSheet.netDebt),
        KeyValueItem(key: 'Short Term Investments', value: balanceSheet.otherShortTermInvestments),
        KeyValueItem(key: 'Total Assets', value: balanceSheet.totalAssets),
        KeyValueItem(key: 'Total Debt', value: balanceSheet.totalDebt),
        KeyValueItem(key: 'Total Liabilities', value: balanceSheet.totalLiabilities),
      ],
    );
  }

  Widget _buildCashFlowCard() {
    final cashFlow = stockFinancials.cashFlow;
    if (cashFlow == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Cash Flow',
      iconData: Icons.attach_money_outlined,
      gradientColors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'Capital Expenditures', value: cashFlow.capitalExpenditures),
        KeyValueItem(key: 'Free Cash Flow', value: cashFlow.freeCashFlow),
        KeyValueItem(key: 'Operating Cash Flow', value: cashFlow.totalCashFlowFromOperations),
      ],
    );
  }

  Widget _buildIncomeStatementCard() {
    final incomeStatement = stockFinancials.incomeStatement;
    if (incomeStatement == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Income Statement',
      iconData: Icons.insert_chart_outlined,
      gradientColors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'Total Revenue', value: incomeStatement.totalRevenue),
        KeyValueItem(key: 'Cost of Revenue', value: incomeStatement.costOfRevenue),
        KeyValueItem(key: 'Gross Profit', value: incomeStatement.grossProfit),
        KeyValueItem(key: 'Operating Income', value: incomeStatement.operatingIncome),
        KeyValueItem(key: 'Operating Margins', value: incomeStatement.operatingMargins),
        KeyValueItem(key: 'Net Income', value: incomeStatement.netIncome),
        KeyValueItem(key: 'Profit Margins', value: incomeStatement.profitMargins),
        KeyValueItem(key: 'EBITDA', value: incomeStatement.ebitda),
        KeyValueItem(key: 'EBITDA Margins', value: incomeStatement.ebitdaMargins),
        KeyValueItem(key: 'Revenue Growth', value: incomeStatement.revenueGrowth),
      ],
    );
  }

  Widget _buildDividendsSplitsCard() {
    final dividendsSplits = stockFinancials.dividendsSplits;
    if (dividendsSplits == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Dividends & Splits',
      iconData: Icons.call_split_outlined,
      gradientColors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'Dividend Date', value: dividendsSplits.dividendDate),
        KeyValueItem(key: 'Last Dividend Paid', value: dividendsSplits.lastDividendPaid),
        KeyValueItem(key: 'Last Stock Split Date', value: dividendsSplits.lastStockSplitDate),
        KeyValueItem(key: 'Last Stock Split Ratio', value: dividendsSplits.lastStockSplitRatio),
      ],
    );
  }

  Widget _buildRiskGovernanceCard() {
    final riskGovernance = stockFinancials.riskGovernance;
    if (riskGovernance == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Risk & Governance',
      iconData: Icons.gpp_good_outlined,
      gradientColors:[Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'Overall Risk Score', value: riskGovernance.overallRiskScore),
        KeyValueItem(key: 'Audit Risk', value: riskGovernance.auditRisk),
        KeyValueItem(key: 'Board Risk', value: riskGovernance.boardRisk),
        KeyValueItem(key: 'Compensation Risk', value: riskGovernance.compensationRisk),
        KeyValueItem(key: 'Shareholder Rights Risk', value: riskGovernance.shareholderRightsRisk),
      ],
    );
  }

  Widget _buildShareholderHoldingsCard() {
    final shareholderHoldings = stockFinancials.shareholderHoldings;
    if (shareholderHoldings == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Shareholder Holdings',
      iconData: Icons.groups_outlined,
      gradientColors:[Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'Float Shares', value: shareholderHoldings.floatShares),
        KeyValueItem(key: 'Held By Insiders', value: shareholderHoldings.heldByInsiders),
        KeyValueItem(key: 'Held By Institutions', value: shareholderHoldings.heldByInstitutions),
        KeyValueItem(key: 'Treasury Shares', value: shareholderHoldings.treasurySharesNumber),
      ],
    );
  }

  Widget _buildValuationCard() {
    final valuation = stockFinancials.valuation;
    if (valuation == null) return const SizedBox.shrink();

    return _buildCard(
      title: 'Valuation',
      iconData: Icons.trending_up_outlined,
      gradientColors:[Color(0xFF6448FE), Color(0xFF5FC6FF)],
      items: [
        KeyValueItem(key: 'P/E Ratio (Trailing)', value: valuation.trailingPERatio),
        KeyValueItem(key: 'P/E Ratio (Forward)', value: valuation.forwardPERatio),
        KeyValueItem(key: 'P/B Ratio', value: valuation.priceToBookRatio),
        KeyValueItem(key: 'P/S Ratio', value: valuation.priceToSalesRatio),
        KeyValueItem(key: 'EV/EBITDA', value: valuation.enterpriseValueToEBITDA),
        KeyValueItem(key: 'EV/Revenue', value: valuation.enterpriseValueToRevenue),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData iconData,
    required List<Color> gradientColors,
    required List<KeyValueItem> items,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColors[0].withOpacity(0.1),
            gradientColors[1].withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: gradientColors[0].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(iconData, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: items
                  .where((item) => item.value != null)
                  .map((item) => _buildKeyValueRow(item, gradientColors[0]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(KeyValueItem item, Color accentColor) {
    final formattedValue = _formatValue(item.value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.key,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            formattedValue,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'N/A';

    if (value is double) {
      if (value < 0.01 && value > -0.01 && value != 0) {
        return value.toStringAsExponential(2);
      }
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }

    if (value is int) {
      if (value.abs() >= 1000000000) {
        return '${(value / 1000000000).toStringAsFixed(2)}B';
      } else if (value.abs() >= 1000000) {
        return '${(value / 1000000).toStringAsFixed(2)}M';
      } else if (value.abs() >= 1000) {
        return '${(value / 1000).toStringAsFixed(2)}K';
      }
    }

    return value.toString();
  }
}

class KeyValueItem {
  final String key;
  final dynamic value;

  KeyValueItem({required this.key, required this.value});
}