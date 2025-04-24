import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/providers/product_detail_provider.dart';

class ProductImagesViewer extends ConsumerWidget {
  final Product product;
  final String selectedImageUrl;
  final List<String> productImages;

  const ProductImagesViewer({
    super.key,
    required this.product,
    required this.selectedImageUrl,
    required this.productImages,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Main Image
        Expanded(
          child: _buildMainImage(),
        ),
        // Thumbnails
        if (productImages.length > 1)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildThumbnail(ref, productImages[index]),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMainImage() {
    if (selectedImageUrl.isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported, size: 48),
      );
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 3.0,
      child: CachedNetworkImage(
        imageUrl: selectedImageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 8),
              Text(
                'Failed to load image',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(WidgetRef ref, String imageUrl) {
    if (imageUrl.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Icon(Icons.image_not_supported),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        ref.read(selectedImageProvider(product).notifier).selectImage(imageUrl);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedImageUrl == imageUrl ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error_outline),
          ),
        ),
      ),
    );
  }
} 