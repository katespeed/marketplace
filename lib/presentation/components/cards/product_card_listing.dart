import 'package:flutter/material.dart';

class ProductCardListing extends StatefulWidget {
  final dynamic product;

  const ProductCardListing({super.key, required this.product});

  @override
  ProductCardListingState createState() => ProductCardListingState();
}

class ProductCardListingState extends State<ProductCardListing> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: widget.product.imageUrls?.isNotEmpty == true
                    ? Image.network(
                        widget.product.imageUrls?.isNotEmpty == true
                        ? widget.product.imageUrls!.first
                        : 'https://via.placeholder.com/150',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                                child:
                                    Icon(Icons.image_not_supported, size: 80)),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 80),
                        ),
                      ),
              ),
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
                Text(
                  isExpanded
                      ? widget.product.description
                      : '${widget.product.description.substring(0, widget.product.description.length > 50 ? 50 : widget.product.description.length)}...',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: isExpanded ? null : 2,
                  overflow: isExpanded ? null : TextOverflow.ellipsis,
                ),
                if (widget.product.description.length > 50)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(isExpanded ? 'Read Less' : 'Read More'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
