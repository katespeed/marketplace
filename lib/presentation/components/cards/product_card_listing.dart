import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../buttons/chat_button.dart';

final imageUrlProvider = FutureProvider.family<String, String>((ref, path) async {
  try {
    print('Fetching image URL for path: $path');
    final ref = FirebaseStorage.instance.ref(path);
    final url = await ref.getDownloadURL();
    final cleanUrl = url.split('?')[0];
    final resizedUrl = '$cleanUrl?alt=media&token=${DateTime.now().millisecondsSinceEpoch}';
    print('Successfully fetched URL: $resizedUrl');
    return resizedUrl;
  } catch (e, stackTrace) {
    print('Error getting download URL: $e');
    print('Stack trace: $stackTrace');
    print('Storage path: $path');
    print('Storage bucket: ${FirebaseStorage.instance.app.options.storageBucket}');
    rethrow;
  }
});

class ProductCardListing extends ConsumerWidget {
  final dynamic product;

  const ProductCardListing({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: product.imageUrls?.isNotEmpty == true
                  ? ref.watch(imageUrlProvider(product.imageUrls![0])).when(
                        data: (url) => Image.network(
                          url,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          cacheWidth: 80,
                          cacheHeight: 80,
                          headers: const {
                            'Origin': 'https://campus-flea.firebasestorage.app',
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[200],
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image:');
                            print('URL: $url');
                            print('Error type: ${error.runtimeType}');
                            print('Error message: $error');
                            print('Stack trace: $stackTrace');
                            return Container(
                              color: Colors.grey[200],
                              width: 80,
                              height: 80,
                              child: const Icon(Icons.error, size: 30, color: Colors.red),
                            );
                          },
                        ),
                        loading: () => Container(
                          color: Colors.grey[200],
                          width: 80,
                          height: 80,
                          child: const CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) {
                          print('Provider error: $error');
                          print('Stack trace: $stackTrace');
                          return Container(
                            color: Colors.grey[200],
                            width: 80,
                            height: 80,
                            child: const Icon(Icons.error, size: 30, color: Colors.red),
                          );
                        },
                      )
                  : Container(
                      color: Colors.red[200],
                      width: 80,
                      height: 80,
                      child: const Icon(Icons.image_not_supported, size: 30),
                    ),
            ),
            const SizedBox(width: 12),
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price}',
                    style:
                        const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description.length > 60
                        ? '${product.description.substring(0, 60)}...'
                        : product.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Intekhab:
            ChatButton(sellerId: product.sellerId), // Use actual seller ID from your product model
            // Button
            ElevatedButton(
              onPressed: () {
                // Implement Sara <3
              },
              child: const Text('Proceed to payment'),
            ),
          ],
        ),
      ),
    );
  }
}