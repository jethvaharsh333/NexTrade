import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';

class StockCard extends StatelessWidget {
  final StockList stock;
  final bool isFavorite;
  final Function(String) onFavoriteToggle;

  const StockCard({
    required this.stock,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: _buildStockImage(stock.stockImage),
        title: Text(stock.stockName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Symbol: ${stock.stockSymbol}", style: TextStyle(color: Colors.grey[700])),
            Text("Face Value: ${stock.faceValue}", style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        trailing: Column(
          children: [
            InkWell(
              child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
              onTap: () => onFavoriteToggle(stock.stockSymbol),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: () {
          context.go('/search/stockdetail/${stock.stockSymbol}.NS');
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
