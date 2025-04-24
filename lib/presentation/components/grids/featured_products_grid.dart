import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app/domain/models/product.dart';

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

class FeaturedProductsGrid extends ConsumerWidget {
  final List<Product> products;

  const FeaturedProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate the height of two rows of products
    const double twoRowsHeight = (180 * 2) + 20;
    return SizedBox(
      width: double.infinity,
      height: twoRowsHeight,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 20,
        runSpacing: 20,
        children: products.map((product) => _buildProductCard(ref, product)).toList(),
      ),
    );
  }

  Widget _buildProductCard(WidgetRef ref, Product product) {
    return SizedBox(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: product.imageUrls.isNotEmpty
                  ? ref.watch(imageUrlProvider(product.imageUrls[0])).when(
                        data: (url) => Image.network(
                          url,
                          width: 180,
                          height: 120,
                          fit: BoxFit.cover,
                          headers: const {
                            'Origin': 'https://campus-flea.firebasestorage.app',
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 180,
                              height: 120,
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 180,
                                height: 120,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported),
                              ),
                        ),
                        loading: () => Container(
                          width: 180,
                          height: 120,
                          color: Colors.grey[200],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        error: (error, stackTrace) =>
                            Container(
                              width: 180,
                              height: 120,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            ),
                      )
                  : Container(
                      width: 180,
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 