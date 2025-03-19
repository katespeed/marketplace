import 'package:flutter/material.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/presentation/components/cards/product_card.dart';

class FeaturedProductsGrid extends StatelessWidget {
  final List<Product> products;

  const FeaturedProductsGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the height of two rows of products
    const double twoRowsHeight = (180 * 2) + 20;
    return SizedBox(
      width: double.infinity,
      height: twoRowsHeight,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 20,
        runSpacing: 20,
        children: products.map((product) => ProductCard(product: product)).toList(),
      ),
    );
  }
} 