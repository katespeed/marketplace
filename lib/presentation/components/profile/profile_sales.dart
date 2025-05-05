// lib/presentation/components/profile/profile_sales.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/providers/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

final imageUrlProvider =
    FutureProvider.family<String, String>((ref, path) async {
  final refStorage = FirebaseStorage.instance.ref(path);
  final url = await refStorage.getDownloadURL();
  return url.split('?')[0];
});

class ProfileSales extends ConsumerWidget {
  final String userId;
  const ProfileSales({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(sellerProductsProvider(userId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sales",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        asyncProducts.when(
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No products uploaded yet'));
            }
            return ListView.separated(
              // ← key to sizing your images correctly!
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildSalesItem(context, ref, product);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error loading sales: $err')),
        ),
      ],
    );
  }

  Widget _buildSalesItem(BuildContext context, WidgetRef ref, Product product) {
    final date = product.createdAt != null
        ? DateTime.parse(product.createdAt!).toLocal()
        : null;
    final formattedDate =
        date != null ? '${date.year}/${date.month}/${date.day}' : 'Unknown';

    return InkWell(
      onTap: () => context.push('/product-detail', extra: product),
      child: ListTile(
        leading: product.imageUrls.isNotEmpty
            ? ref.watch(imageUrlProvider(product.imageUrls.first)).when(
                  data: (url) => CachedNetworkImage(
                    imageUrl: url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  loading: () => const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Icon(Icons.broken_image),
                )
            : const Icon(Icons.image_not_supported, size: 50),
        title: Text(product.name),
        subtitle: Text(formattedDate),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}
