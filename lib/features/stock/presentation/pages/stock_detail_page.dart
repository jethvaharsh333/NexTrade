/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/stock/presentation/widgets/stock_chart.dart';

class StockDetailPage extends StatefulWidget {
  final String stockSymbol;
  const StockDetailPage({super.key, required this.stockSymbol});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  String _selectedPeriod = "1d";
  final List<String> _periods = ['1d', '5d', '1mo', '3mo', '6mo', '1y', '2y', '5y', '10y', 'ytd', 'max'];

  List<StockPrice>? _cachedStockPrices;
  StockFinancials? _cachedFinancials;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() {
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
    context.read<StockBloc>().add(FetchStockFinancialsEvent(stockSymbol: widget.stockSymbol));
  }

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color.fromRGBO(24, 24, 32, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('${widget.stockSymbol} Details', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildStockChartSection(),
                  _buildPeriodSelector(),
                  _buildStockFinancialsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockChartSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is GetStockPriceFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetStockPriceSuccessState) {
          _cachedStockPrices = state.stockPrices;
        }

        return Container(
          height: 300,
          alignment: Alignment.center,
          child: _cachedStockPrices != null
              ? StockChart(stockData: _cachedStockPrices!)
              : state is StockPriceLoadingState
              ? const Loader()
              : const Text('No data available', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Widget _buildPeriodButton(String period) {
    final isSelected = _selectedPeriod == period;

    return GestureDetector(
      onTap: () => _changePeriod(period),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(0, 255, 170, 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color.fromRGBO(0, 255, 170, 1), width: 1) : null,
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isSelected ? const Color.fromRGBO(0, 255, 170, 1) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 24, 32, 1),
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 16),
            ..._periods.map((period) => _buildPeriodButton(period)),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStockFinancialsSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is StockFinancialsFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is StockFinancialsSuccessState) {
          _cachedFinancials = state.stockFinancials;
        }

        return _cachedFinancials != null
            ? _buildFinancialsCard(_cachedFinancials!)
            : state is StockFinancialsLoadingState
            ? const Loader()
            : const Center(child: Text('No financial data available', style: TextStyle(color: Colors.white)));
      },
    );
  }

  Widget _buildFinancialsCard(StockFinancials financials) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Financials', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            _buildFinancialRow('Market Cap:', financials.generalInfo?.marketCap),
            _buildFinancialRow('Book Value/Share:', financials.balanceSheet?.bookValuePerShare),
            _buildFinancialRow('CapEx:', financials.cashFlow?.capitalExpenditures),
            _buildFinancialRow('Dividend Date:', financials.dividendsSplits?.dividendDate),
            _buildFinancialRow('Cost of Revenue:', financials.incomeStatement?.costOfRevenue),
            _buildFinancialRow('Audit Risk:', financials.riskGovernance?.auditRisk),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(value != null ? value.toString() : 'N/A', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/stock/presentation/widgets/stock_chart.dart';

class StockDetailPage extends StatefulWidget {
  final String stockSymbol;
  const StockDetailPage({super.key, required this.stockSymbol});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  String _selectedPeriod = "1d";
  final List<String> _periods = ['1d', '5d', '1mo', '3mo', '6mo', '1y', '2y', '5y', '10y', 'ytd', 'max'];

  List<StockPrice>? _cachedStockPrices;
  StockFinancials? _cachedFinancials;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() {
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
    context.read<StockBloc>().add(FetchStockFinancialsEvent(stockSymbol: widget.stockSymbol));
  }

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color.fromRGBO(24, 24, 32, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('${widget.stockSymbol} Details', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildStockChartSection(),
                  _buildPeriodSelector(),
                  _buildStockFinancialsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockChartSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is GetStockPriceFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetStockPriceSuccessState) {
          _cachedStockPrices = state.stockPrices;
        }

        return Container(
          height: 300,
          alignment: Alignment.center,
          child: _cachedStockPrices != null
              ? StockChart(stockData: _cachedStockPrices!)
              : state is StockPriceLoadingState
              ? const Loader()
              : const Text('No data available', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 24, 32, 1),
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 16),
            ..._periods.map((period) => _buildPeriodButton(period)),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final isSelected = _selectedPeriod == period;

    return GestureDetector(
      onTap: () => _changePeriod(period),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(0, 255, 170, 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color.fromRGBO(0, 255, 170, 1), width: 1) : null,
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isSelected ? const Color.fromRGBO(0, 255, 170, 1) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStockFinancialsSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is StockFinancialsFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is StockFinancialsSuccessState) {
          _cachedFinancials = state.stockFinancials;
        }

        return _cachedFinancials != null
            ? Column(
          children: [
            _buildFinancialsCard('Market Cap', _cachedFinancials!.generalInfo?.marketCap),
            _buildFinancialsCard('Book Value/Share', _cachedFinancials!.balanceSheet?.bookValuePerShare),
            _buildFinancialsCard('CapEx', _cachedFinancials!.cashFlow?.capitalExpenditures),
            _buildFinancialsCard('Dividend Date', _cachedFinancials!.dividendsSplits?.dividendDate),
            _buildFinancialsCard('Cost of Revenue', _cachedFinancials!.incomeStatement?.costOfRevenue),
            _buildFinancialsCard('Audit Risk', _cachedFinancials!.riskGovernance?.auditRisk),
            _buildFinancialsCard('Net Income', _cachedFinancials!.incomeStatement?.netIncome),
            _buildFinancialsCard('Operating Expenses', _cachedFinancials!.incomeStatement?.operatingMargins),
          ],
        )
            : state is StockFinancialsLoadingState
            ? const Loader()
            : const Center(child: Text('No financial data available', style: TextStyle(color: Colors.white)));
      },
    );
  }

  Widget _buildFinancialsCard(String title, dynamic value) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text(value != null ? value.toString() : 'N/A', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/stock/presentation/widgets/stock_chart.dart';
import 'package:nextrade/features/stock/presentation/widgets/stock_financial_cards.dart';

class StockDetailPage extends StatefulWidget {
  final String stockSymbol;

  const StockDetailPage({super.key, required this.stockSymbol});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  String _selectedPeriod = "1d";
  final List<String> _periods = ['1d', '5d', '1mo', '3mo', '6mo', '1y', '2y', '5y', '10y', 'ytd', 'max'];

  List<StockPrice>? _cachedStockPrices;
  StockFinancials? _cachedFinancials;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    // context.
  }

  void fetchInitialData() {
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
    context.read<StockBloc>().add(FetchStockFinancialsEvent(stockSymbol: widget.stockSymbol));
  }

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
    context.read<StockBloc>().add(FetchStockPriceEvent(stockSymbol: widget.stockSymbol, period: _selectedPeriod));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color.fromRGBO(24, 24, 32, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('${widget.stockSymbol} Details', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildStockChartSection(),
                  _buildPeriodSelector(),
                  _buildStockFinancialsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockChartSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is GetStockPriceFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetStockPriceSuccessState) {
          _cachedStockPrices = state.stockPrices;
        }

        return Container(
          height: 300,
          alignment: Alignment.center,
          child: _cachedStockPrices != null
              ? StockChart(stockData: _cachedStockPrices!)
              : state is StockPriceLoadingState
                  ? const Loader()
                  : const Text(
                      'No data available',
                      style: TextStyle(color: Colors.white),
                    ),
        );
      },
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 24, 32, 1),
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 16),
            ..._periods.map((period) => _buildPeriodButton(period)),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final isSelected = _selectedPeriod == period;

    return GestureDetector(
      onTap: () => _changePeriod(period),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(0, 255, 170, 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color.fromRGBO(0, 255, 170, 1), width: 1) : null,
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isSelected ? const Color.fromRGBO(0, 255, 170, 1) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Replace your current implementation with this
  Widget _buildStockFinancialsSection() {
    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is StockFinancialsFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is StockFinancialsSuccessState) {
          _cachedFinancials = state.stockFinancials;
        }

        // Use the new StockFinancialsCards widget
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: _cachedFinancials != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Financial Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Use the new redesigned cards component
                    StockFinancialsCards(stockFinancials: _cachedFinancials!),
                    const SizedBox(height: 24),
                  ],
                )
              : state is StockFinancialsLoadingState
                  ? const Center(child: Loader())
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No financial data available',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
