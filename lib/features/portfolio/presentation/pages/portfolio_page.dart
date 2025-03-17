import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';
import 'package:nextrade/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:intl/intl.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  void initState() {
    super.initState();
    context.read<PortfolioBloc>().add(GetPortfolioEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio"),
        actions: [
          InkWell(
            child: const Icon(Icons.add),
            onTap: () {
              GoRouter.of(context).goNamed("EditPortfolio");
            },
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: BlocConsumer<PortfolioBloc, PortfolioState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is GetPortfolioLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green, // Using green to match stock market theme
              ),
            );
          } else if (state is GetPortfolioSuccessState) {
            final portfolio = state.stockPortfolio.portfolio ?? [];
            final summary = state.stockPortfolio.summary;
            final dollarFormat = NumberFormat.currency(symbol: '₹', decimalDigits: 2);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Portfolio Summary Card
                    if (summary != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E), // Dark card like in image 1
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      dollarFormat.format(summary.totalInvestment),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Total Investment",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      dollarFormat.format(summary.totalCurrentValue),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Current Value",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Divider(color: Colors.grey, height: 1, thickness: 1),
                            ),
                            Text(
                              summary.totalGainLoss >= 0
                                  ? dollarFormat.format(summary.totalGainLoss).replaceAll('\$', '')
                                  : dollarFormat.format(summary.totalGainLoss).replaceAll('\$', ''),
                              style: TextStyle(
                                color: summary.totalGainLoss >= 0 ? Colors.white : Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Portfolio Stock List
                    if (portfolio.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(Icons.sentiment_dissatisfied, color: Colors.grey, size: 48),
                              SizedBox(height: 16),
                              Text(
                                "No stocks in portfolio.",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Tap the + button to add stocks",
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: portfolio.length,
                        itemBuilder: (context, index) {
                          final stock = portfolio[index];
                          // final gainLossPercent = (stock.currentPrice - stock.investmentPrice) /
                          //     stock.quantity * 100;
                          final gainLossPercent = stock.todaysGainLoss;
                          final isPositive = stock.absoluteGainLoss >= 0;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1F2B), // Dark card background
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        stock.stockSymbol,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        isPositive
                                            ? "+${dollarFormat.format(stock.absoluteGainLoss).replaceAll('\$', '')}"
                                            : dollarFormat.format(stock.absoluteGainLoss).replaceAll('\$', ''),
                                        style: TextStyle(
                                          color: isPositive ? Colors.green : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        stock.stockName,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),

                                      ),
                                      Text(
                                        "${gainLossPercent.toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          color: isPositive ? Colors.green : Colors.red,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Bought Price: ${dollarFormat.format(stock.investmentPrice)}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "Qty: ${stock.quantity} | LTP: ${dollarFormat.format(stock.currentPrice)}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 80), // Space for bottom navigation
                  ],
                ),
              ),
            );
          }
          else if (state is GetPortfolioFailureState) {
            return const Center(
              child: Text(
                "No Stocks in portfolio",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          else {
            return const Center(
              child: Text(
                "Unable to load portfolio",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
