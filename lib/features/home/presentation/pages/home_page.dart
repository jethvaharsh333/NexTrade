import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';
import 'package:nextrade/core/theme/app_pallete.dart';
import 'package:nextrade/features/home/presentation/bloc/home_bloc.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';
import 'package:nextrade/features/home/presentation/widgets/spline.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (context.read<HomeBloc>().state is! FetchingIndexSuccess) {
      print("Fetching indices...");
      context.read<HomeBloc>().add(FetchingStockIndicesEvent());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 32, 1),
      appBar: AppBar(
        title: const Text("NexTrade", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(24, 24, 32, 1),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is FetchingIndexFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is IndicesLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.green,
            ));
          } else if (state is FetchingIndexSuccess) {
            return _buildContent(state.stockIndices);
          } else if (state is FetchingIndexFailure) {
            return Center(child: Text("Failed to load data: ${state.message}",
                style: TextStyle(color: Colors.white)));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildContent(List<StockIndex> indices) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBalanceSection(),
          SizedBox(height: 200, child: spline()),
          _buildMarketAndSectors(indices),
        ],
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Balance", style: TextStyle(color: Colors.white)),
          Text("Rs. 20,00,000", style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildMarketAndSectors(List<StockIndex> indices) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Market and Sectors", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("View More", style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 230, // Increased height to accommodate content
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: List.generate((indices.length / 3).ceil(), (i) {
            final start = i * 3;
            final end = (start + 3) > indices.length ? indices.length : (start + 3);
            return _buildStockIndexCard(indices.sublist(start, end));
          }),
        ),
        SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate((indices.length / 3).ceil(), (index) {
            return Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index ? Colors.green : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStockIndexCard(List<StockIndex> indices) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Reduced vertical margin
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use minimum space needed
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < indices.length; i++)
            _buildStockRow(indices[i], i, indices.length),
        ],
      ),
    );
  }

  Widget _buildStockRow(StockIndex index, int currentPosition, int totalItems) {
    final isPositive = (index.percentageChange ?? 0) >= 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0), // Reduced vertical padding
      child: Column(
        // mainAxisSize: MainAxisSize.min, // Use minimum space needed
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(index.indexName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${index.priceChange}", style: TextStyle(color: Colors.white, fontSize: 14)),
                  Text("${(isPositive ? "" : "-")}${index.percentageChange?.abs() ?? 0}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8), // Reduced spacing
          if (currentPosition < totalItems - 1)
            Divider(color: Colors.grey.shade800, height: 1),
        ],
      ),
    );
  }
}