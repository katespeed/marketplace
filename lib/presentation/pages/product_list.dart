import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/cards/product_card_listing.dart';
import 'package:my_flutter_app/providers/product_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productListProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: asyncProducts.when(
        data: (productList) {
          // Preload images
          for (final product in productList) {
            if (product.imageUrls.isNotEmpty) {
              try {
                final imageUrl = product.imageUrls[0];
                if (imageUrl.startsWith('http')) {
                  precacheImage(
                    NetworkImage(imageUrl),
                    context,
                  ).catchError((error) {
                    debugPrint('Failed to precache image: $error');
                  });
                }
              } catch (e) {
                debugPrint('Error precaching image: $e');
              }
            }
          }
          
          return productList.isEmpty
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
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text("Error loading products: $error")),
      ),
    );
  }
}
