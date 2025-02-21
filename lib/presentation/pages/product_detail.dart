import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String selectedImageUrl;

  @override
  void initState() {
    super.initState();
    selectedImageUrl = widget.product.imageUrl;
  }

  // ダミーの画像URLリストを6枚に増やす
  List<String> get productImages => [
        widget.product.imageUrl,
        '${widget.product.imageUrl}?v=2',
        '${widget.product.imageUrl}?v=3',
        '${widget.product.imageUrl}?v=4',
        '${widget.product.imageUrl}?v=5',
        '${widget.product.imageUrl}?v=6',
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Product Images
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // Main Image
                      InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(20.0),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: SizedBox(
                          height: 400,
                          child: selectedImageUrl.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl: selectedImageUrl,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                )
                              : Image.asset(
                                  selectedImageUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
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
                                itemBuilder: (context, index) {
                                  final imageUrl = productImages[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageUrl = imageUrl;
                                      });
                                    },
                                    child: Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: selectedImageUrl == imageUrl
                                              ? Colors.blue
                                              : Colors.grey[300]!,
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
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Center(
                                                child: Icon(Icons.error),
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                // Right Column - Product Information
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.product.brand != null)
                        Text(
                          widget.product.brand!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      Text(
                        widget.product.name,
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
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (widget.product.rentalPrice != null)
                            Text(
                              'or rent for \$${widget.product.rentalPrice!.toStringAsFixed(2)}/day',
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
                            text: 'Add to Cart',
                            backgroundColor: Colors.cyan,
                            onPressed: () {
                              // TODO: Implement add to cart functionality
                            },
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      // Product Details
                      if (widget.product.description != null) ...[
                        const Text(
                          'About this item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.product.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                      if (widget.product.categories != null && widget.product.categories!.isNotEmpty) ...[
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
                          children: widget.product.categories!
                              .map((category) => Chip(
                                    label: Text(category),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (widget.product.size != null && widget.product.size!.isNotEmpty) ...[
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.size!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (widget.product.color != null && widget.product.color!.isNotEmpty) ...[
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.color!,
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
                            backgroundImage: widget.product.sellerImageUrl != null
                                ? NetworkImage(widget.product.sellerImageUrl!)
                                : null,
                            child: widget.product.sellerImageUrl == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.sellerName ?? 'Unknown Seller',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (widget.product.rating != null && widget.product.reviewCount != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${widget.product.rating!.toStringAsFixed(1)} (${widget.product.reviewCount} reviews)',
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