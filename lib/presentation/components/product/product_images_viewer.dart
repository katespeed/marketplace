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
        InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.3,
          maxScale: 4.0,
          child: SizedBox(
            height: 400,
            child: _buildMainImage(selectedImageUrl),
          ),
        ),
        const SizedBox(height: 16),
        // Thumbnail Images
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: productImages.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) => _buildThumbnail(
                    ref,
                    productImages[index],
                    selectedImageUrl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainImage(String imageUrl) {
    return imageUrl.startsWith('http')
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error),
            ),
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.error),
            ),
          );
  }

  Widget _buildThumbnail(WidgetRef ref, String imageUrl, String selectedImageUrl) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedImageProvider(product).notifier).selectImage(imageUrl);
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedImageUrl == imageUrl ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: imageUrl.startsWith('http')
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              )
            : Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
      ),
    );
  }
} 