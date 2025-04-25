import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/cards/product_card_listing.dart';
import 'package:my_flutter_app/providers/product_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProducts = ref.watch(filteredProductsProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found'))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCardListing(product: product);
                },
              ),
            ),
    );
  }
} 