import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required String productId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('ProductDetail Page')),
    );
  }
}