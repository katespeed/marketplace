import 'package:flutter/material.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('ProductDetail Page')),
    );
  }
}