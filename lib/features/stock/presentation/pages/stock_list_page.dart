/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/utils/show_snackbar.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override

  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  late StockBloc stockBloc;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    stockBloc = context.read<StockBloc>();
    stockBloc.add(FetchStockList(page: 1, limit: 10)); // Initial fetch
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !isLoadingMore) {
      _loadMoreStocks();
    }
  }

  void _loadMoreStocks() {
    setState(() => isLoadingMore = true);
    stockBloc.add(FetchStockList(page: stockBloc.currentPage + 1, limit: 10));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock List')),
      body: BlocListener<StockBloc, StockState>(
        listener: (context, state) {
          if (state is GetStockListSuccess) {
            setState(() => isLoadingMore = false);
          } else if (state is GetStockListFailure) {
            setState(() => isLoadingMore = false);
          }

          if (state is AddToWatchlistSuccessState){
            showSnackBar(context, "Added to watchlist");
          } else if (state is AddToWatchlistFailureState){
            showSnackBar(context, "Unable to add stock in watchlist");
          }
        },
        child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            if (state is StockListLoading && stockBloc.allStocks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetStockListFailure) {
              return Center(child: Text('Error: ${state.errorMessage}', style: const TextStyle(color: Colors.red)));
            }
            if (stockBloc.allStocks.isEmpty) {
              return const Center(child: Text('No stocks available'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: stockBloc.allStocks.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == stockBloc.allStocks.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final StockList stock = stockBloc.allStocks[index];
                      return _buildStockCard(stock);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStockCard(StockList stock) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: _buildStockImage(stock.stockImage),
        title: Text(
          stock.stockName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Symbol: ${stock.stockSymbol}",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              "Face Value: ${stock.faceValue}",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Column(
          children: [
            InkWell(
              child: Icon(Icons.favorite_border),
              onTap: (){
                context.read<StockBloc>().add(AddToWatchlistEvent(stockSymbol: stock.stockSymbol));
              },
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: () {
          final concatedSymbol = "${stock.stockSymbol}.NS";
          context.go('/search/stockdetail/${concatedSymbol}');
        },
      ),
    );
  }

  Widget _buildStockImage(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
            ),
          )
        : const Icon(Icons.image, size: 50, color: Colors.grey);
  }
}

 */


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';

class StockListPage extends StatefulWidget {
  @override
  _StockListPageState createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  final ScrollController _scrollController = ScrollController();
  late StockBloc _stockBloc;
  bool isLoadingMore = false;
  bool _watchlistLoaded = false;

  @override
  void initState() {
    super.initState();
    _stockBloc = context.read<StockBloc>();

    _stockBloc.add(FetchWatchlistStocksEvent());

    _stockBloc.add(FetchStockList(page: 1, limit: 10));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        _fetchMoreStocks();
      }
    });
  }

  void _fetchMoreStocks() {
    if (!isLoadingMore) {
      isLoadingMore = true;
      _stockBloc.add(FetchStockList(page: _stockBloc.currentPage + 1, limit: 10));
    }
  }

  void _toggleFavorite(String stockSymbol) {
    final isCurrentlyFavorite = _stockBloc.favoriteStockSymbols.contains(stockSymbol);
    if (isCurrentlyFavorite) {
      _stockBloc.add(RemoveStockFromWatchlistEvent(stockSymbol: stockSymbol));
    } else {
      _stockBloc.add(AddToWatchlistEvent(stockSymbol: stockSymbol));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock List')),
      drawer: const MyDrawer(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StockBloc, StockState>(
            listener: (context, state) {
              if (state is FetchWatchlistStocksSuccessState) {
                setState(() {
                  _watchlistLoaded = true;
                });
              }
            },
          ),
          BlocListener<StockBloc, StockState>(
            listener: (context, state) {
              if (state is GetStockListSuccess) {
                isLoadingMore = false;
              }
            },
          ),
        ],
        child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            if (!_watchlistLoaded || (state is StockListLoading && _stockBloc.allStocks.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetStockListFailure) {
              return Center(child: Text(state.errorMessage));
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: _stockBloc.allStocks.length + 1, // +1 for loading indicator
              itemBuilder: (context, index) {
                if (index == _stockBloc.allStocks.length) {
                  return _buildLoadingIndicator();
                }
                final stock = _stockBloc.allStocks[index];
                final isFavorite = _stockBloc.favoriteStockSymbols.contains(stock.stockSymbol);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: _buildStockImage(stock.stockSymbol),
                    title: Text(
                      stock.stockName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Symbol: ${stock.stockSymbol}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "Face Value: ${stock.faceValue}",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () => _toggleFavorite(stock.stockSymbol),
                        ),
                      ],
                    ),
                    onTap: () {
                      final concatedSymbol = "${stock.stockSymbol}.NS";
                      context.go('/search/stockdetail/${concatedSymbol}');
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildStockImage(String? imageUrl) {
    String sym = imageUrl!.toLowerCase();
    return imageUrl != null && imageUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://logo.clearbit.com/${sym}.com",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          )
        : const Icon(Icons.image, size: 50, color: Colors.grey);
  }

  Widget _buildLoadingIndicator() {
    return isLoadingMore
        ? const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          )
        : const SizedBox.shrink();
  }
}
