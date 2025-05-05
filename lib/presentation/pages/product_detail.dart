import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/image_viewer/product_images_viewer.dart';
import 'package:my_flutter_app/applications/firebase_storage/storage_service.dart';
import 'package:my_flutter_app/presentation/components/buttons/chat_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app/presentation/components/profile/profile_reviews.dart';
import 'package:my_flutter_app/presentation/pages/user_profile_page.dart';

final storageServiceProvider = Provider((ref) => StorageService());

final productImageUrlsProvider =
    FutureProvider.family<List<String>, List<String>>((ref, paths) async {
  if (paths.isEmpty) return [];
  try {
    final storageService = ref.watch(storageServiceProvider);
    return storageService.getImageUrls(paths);
  } catch (e) {
    debugPrint('Error getting product image URLs: $e');
    return [];
  }
});

final sellerImageUrlProvider =
    FutureProvider.family<String?, String?>((ref, path) async {
  if (path == null) return null;
  try {
    final ref = FirebaseStorage.instance.ref(path);
    final url = await ref.getDownloadURL();
    final cleanUrl = url.split('?')[0];
    final resizedUrl =
        '$cleanUrl?alt=media&token=${DateTime.now().millisecondsSinceEpoch}';
    return resizedUrl;
  } catch (e) {
    debugPrint('Error getting seller image URL: $e');
    return null;
  }
});

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrlsAsync =
        ref.watch(productImageUrlsProvider(product.imageUrls));
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 400,
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        // Image viewer
                        Expanded(
                          child: imageUrlsAsync.when(
                            data: (urls) => ProductImagesViewer(
                              product: product,
                              selectedImageUrl: urls.isNotEmpty ? urls[0] : '',
                              productImages: urls,
                            ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stack) => Center(
                              child: Text('Error loading images: $error'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                // Right Column - Product Information
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Purchase Button
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (product.sellerId != null)
                            ChatButton(sellerId: product.sellerId!)
                          else
                            const Text(
                              'Seller information not available',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                      const Divider(height: 32),
                      // Product Details
                      if (product.description != null) ...[
                        const Text(
                          'About this item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                      if (product.categories != null &&
                          product.categories!.isNotEmpty) ...[
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: product.categories!
                              .map((category) => Chip(
                                    label: Text(category),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (product.size != null && product.size!.isNotEmpty) ...[
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.size!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                      ],
                      const Divider(height: 32),
                      // Seller Information
                      const Text(
                        'Seller Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final sellerImageUrlAsync = ref.watch(
                                  sellerImageUrlProvider(
                                      product.sellerImageUrl));
                              return sellerImageUrlAsync.when(
                                data: (url) => CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                  child: url != null
                                      ? ClipOval(
                                          child: Image.network(
                                            url,
                                            fit: BoxFit.cover,
                                            cacheWidth: 60,
                                            cacheHeight: 60,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const Icon(Icons.person,
                                          size: 40, color: Colors.white),
                                ),
                                loading: () => const CircleAvatar(
                                  radius: 30,
                                  child: CircularProgressIndicator(),
                                ),
                                error: (_, __) => const CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.error),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserProfilePage(
                                          userId: product.sellerId!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    product.sellerName ?? 'Unknown Seller',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ProfileReviews(userId: product.sellerId!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
