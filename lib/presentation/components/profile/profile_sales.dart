import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

final imageUrlProvider = FutureProvider.family<String, String>((ref, path) async {
  try {
    final ref = FirebaseStorage.instance.ref(path);
    final url = await ref.getDownloadURL();
    final cleanUrl = url.split('?')[0];
    final resizedUrl = '$cleanUrl?alt=media&token=${DateTime.now().millisecondsSinceEpoch}';
    return resizedUrl;
  } catch (e) {
    rethrow;
  }
});

class ProfileSales extends ConsumerWidget {
  const ProfileSales({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final asyncProducts = ref.watch(sellerProductsProvider(user!.uid));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        asyncProducts.when(
          data: (products) {
            // Preload images
            for (final product in products) {
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
            
            return products.isEmpty
                ? const Center(child: Text('No products uploaded yet'))
                : Column(
                    children: products.map((product) => _buildSalesItem(context, ref, product)).toList(),
                  );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text("Error loading products: $error")),
        ),
      ],
    );
  }

  Widget _buildSalesItem(BuildContext context, WidgetRef ref, Product product) {
    final date = product.createdAt != null
        ? DateTime.parse(product.createdAt!).toLocal()
        : null;
    final formattedDate = date != null
        ? '${date.year}/${date.month}/${date.day}'
        : 'No date';

    return InkWell(
      onTap: () {
        context.push(
          '/product-detail',
          extra: product,
        );
      },
      child: ListTile(
        leading: product.imageUrls.isNotEmpty
            ? ref.watch(imageUrlProvider(product.imageUrls[0])).when(
                  data: (url) => CachedNetworkImage(
                    imageUrl: url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    memCacheWidth: 50,
                    memCacheHeight: 50,
                    placeholder: (context, url) => const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                  ),
                  loading: () => const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => const Icon(Icons.broken_image),
                )
            : const Icon(Icons.image_not_supported),
        title: Text(product.name),
        subtitle: Text(formattedDate),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
