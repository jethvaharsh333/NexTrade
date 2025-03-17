// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nextrade/core/common/widgets/loader.dart';
// import 'package:nextrade/core/common/widgets/my_drawer.dart';
// import 'package:nextrade/core/utils/show_snackbar.dart';
// import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
// import 'package:nextrade/features/watchlist/presentation/bloc/watchlist_bloc.dart';
//
// class WatchlistPage extends StatefulWidget {
//   const WatchlistPage({super.key});
//
//   @override
//   State<WatchlistPage> createState() => _WatchlistPageState();
// }
//
// class _WatchlistPageState extends State<WatchlistPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<WatchlistBloc>().add(FetchWatchlistStocksWithFinanceEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Watchlist"),
//       ),
//       drawer: const MyDrawer(),
//       body: BlocConsumer<WatchlistBloc, WatchlistState>(
//         listener: (context, state) {
//           if (state is FetchWatchlistStocksFailureState) {
//             showSnackBar(context, state.failureMessage);
//           }
//         },
//         builder: (context, state) {
//           if(state is FetchWatchlistStocksLoadingState){
//             return const Loader();
//           }
//           else if(state is FetchWatchlistStocksSuccessState){
//             return _buildWatchlist(state.watchlistStock);
//           }
//           else {
//             return const Center(child: Text("No data available"));
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWatchlist(List<WatchlistStock>? stocks) {
//     if (stocks == null || stocks.isEmpty) {
//       return const Center(child: Text("No stocks in watchlist"));
//     }
//     return ListView.builder(
//       itemCount: stocks.length,
//       itemBuilder: (context, index) {
//         final stock = stocks[index];
//         return ListTile(
//           leading: stock.stockImage != null
//               ? Image.network(stock.stockImage!, width: 40, height: 40)
//               : const Icon(Icons.show_chart),
//           title: Text(stock.stockName),
//           subtitle: Text(stock.industry),
//           trailing: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("₹${stock.currentPrice.toStringAsFixed(2)}"),
//               Text(
//                 "${stock.todaysGainLoss.toStringAsFixed(2)}%",
//                 style: TextStyle(
//                   color: stock.todaysGainLoss >= 0 ? Colors.green : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// /*
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nextrade/features/watchlist/presentation/bloc/watchlist_bloc.dart';
// import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
//
// class WatchlistPage extends StatefulWidget {
//   const WatchlistPage({super.key});
//
//   @override
//   State<WatchlistPage> createState() => _WatchlistPageState();
// }
//
// class _WatchlistPageState extends State<WatchlistPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<WatchlistBloc>().add(FetchWatchlistStocksWithFinanceEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Watchlist"),
//       ),
//       body: BlocConsumer<WatchlistBloc, WatchlistState>(
//         listener: (context, state) {
//           if (state is FetchWatchlistStocksFailureState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.failureMessage)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is FetchWatchlistStocksLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is FetchWatchlistStocksSuccessState) {
//             return _buildWatchlist(state.watchlistStock);
//           } else {
//             return const Center(child: Text("No data available"));
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWatchlist(List<WatchlistStock>? stocks) {
//     if (stocks == null || stocks.isEmpty) {
//       return const Center(child: Text("No stocks in watchlist"));
//     }
//     return ListView.builder(
//       itemCount: stocks.length,
//       itemBuilder: (context, index) {
//         final stock = stocks[index];
//         return ListTile(
//           leading: stock.stockImage != null
//               ? Image.network(stock.stockImage!, width: 40, height: 40)
//               : const Icon(Icons.show_chart),
//           title: Text(stock.stockName),
//           subtitle: Text(stock.industry),
//           trailing: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("₹${stock.currentPrice.toStringAsFixed(2)}"),
//               Text(
//                 "${stock.todaysGainLoss.toStringAsFixed(2)}%",
//                 style: TextStyle(
//                   color: stock.todaysGainLoss >= 0 ? Colors.green : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
// */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/common/widgets/loader.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
import 'package:nextrade/features/watchlist/presentation/bloc/watchlist_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(FetchWatchlistStocksWithFinanceEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: BlocConsumer<WatchlistBloc, WatchlistState>(
        listener: (context, state) {
          if (state is FetchWatchlistStocksFailureState) {
            showSnackBar(context, state.failureMessage);
          }
        },
        builder: (context, state) {
          if(state is FetchWatchlistStocksLoadingState){
            return const Loader();
          }
          else if(state is FetchWatchlistStocksSuccessState){
            return _buildWatchlist(state.watchlistStock);
          }
          else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.exclamationCircle, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No data available",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildWatchlist(List<WatchlistStock>? stocks) {
    if (stocks == null || stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LineIcons.hourglassEnd, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No stocks in watchlist",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              "Add stocks to begin tracking",
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          final isPositive = stock.todaysGainLoss >= 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Left section - Stock image or icon
                    Container(
                      width: 50,
                      height: 50,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[200],
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: stock.todaysGainLoss>=0 ? const Icon(Icons.trending_up, size: 30) : const Icon(Icons.trending_down, size: 30),
                    ),

                    const SizedBox(width: 16),

                    // Middle section - Stock info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stock.stockName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stock.stockSymbol,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right section - Price and gain/loss
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${stock.currentPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              isPositive ? LineIcons.arrowUp : LineIcons.arrowDown,
                              color: isPositive ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${stock.todaysGainLoss.abs().toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isPositive ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Delete button
                    IconButton(
                      icon: const Icon(
                        LineIcons.trash,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Add delete functionality
                        _showDeleteConfirmationDialog(stock);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(WatchlistStock stock) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove from Watchlist"),
        content: Text("Are you sure you want to remove ${stock.stockName} from your watchlist?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Add the bloc event to remove the stock
              context.read<WatchlistBloc>().add(RemoveFromWatchlistEvent(stockSymbol: stock.stockSymbol));
              Navigator.of(context).pop();
            },
            child: const Text("Remove", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}