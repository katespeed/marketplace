import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedImageUrl = ref.watch(selectedImageProvider(product));

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   flex: 5,
                //   child: ProductImagesViewer(
                //     product: product,
                //     selectedImageUrl: selectedImageUrl,
                //     productImages: product.imageUrls,
                //   ),
                // ),
                const SizedBox(width: 40),
                // Right Column - Product Information
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.brand != null)
                        Text(
                          product.brand!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
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
                          if (product.rentalPrice != null)
                            Text(
                              'or rent for \$${product.rentalPrice!.toStringAsFixed(2)}/day',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Purchase Button
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomButton(
                            text: 'Buy Now',
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              // TODO: Implement checkout functionality
                            },
                          ),
                          const SizedBox(height: 12),
                          CustomButton(
                            text: 'Rent Now',
                            backgroundColor: Colors.cyan,
                            onPressed: () {
                              // TODO: Implement add to cart functionality
                            },
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
                      if (product.categories != null && product.categories!.isNotEmpty) ...[
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
                      if (product.color != null && product.color!.isNotEmpty) ...[
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.color!,
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
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: product.sellerImageUrl != null
                                ? NetworkImage(product.sellerImageUrl!)
                                : null,
                            child: product.sellerImageUrl == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.sellerName ?? 'Unknown Seller',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (product.rating != null && product.reviewCount != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${product.rating!.toStringAsFixed(1)} (${product.reviewCount} reviews)',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
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