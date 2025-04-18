import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/cards/product_card_listing.dart';
import '../../providers/product_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: asyncProducts.when(
        data: (productList) => productList.isEmpty
            ? const Center(child: Text('No products uploaded yet'))
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return ProductCardListing(product: product);
                  },
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text("Error loading products: $error")),
      ),
    );
  }
}
