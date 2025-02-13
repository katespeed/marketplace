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
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 20,
        runSpacing: 20,
        children: products.map((product) => ProductCard(product: product)).toList(),
      ),
    );
  }
} 