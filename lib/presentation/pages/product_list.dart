import 'package:flutter/material.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('ProductList Page')),
    );
  }
}