import 'package:flutter/material.dart';
import 'package:my_flutter_app/data/mock/featured_products.dart';
import 'package:my_flutter_app/domain/models/product.dart';

class ProfileSales extends StatelessWidget {
  // mockFeaturedProductsから販売データを生成
  final List<Map<String, dynamic>> sales = mockFeaturedProducts
      .take(4)  // 最初の4つの商品のみ使用
      .map((product) => {
            'product': product,
            'date': 'Mar ${1 + mockFeaturedProducts.indexOf(product)}, 2024',
          })
      .toList();

  ProfileSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Column(
          children: sales.map((sale) => _buildSalesItem(sale)).toList(),
        ),
      ],
    );
  }

  Widget _buildSalesItem(Map<String, dynamic> sale) {
    final Product product = sale['product'] as Product;
    return ListTile(
      leading: product.imageUrls.isNotEmpty == true
      ? Image.network(
        product.imageUrls[0],
        width: 50, 
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image),
      )
      : const Icon(Icons.image_not_supported),
      title: Text(product.name),
      subtitle: Text(sale['date']),
      trailing: Text(
        '\$${product.price.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
      ),
    );
  }
}
