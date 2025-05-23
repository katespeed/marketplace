import 'package:flutter/material.dart';
import 'package:my_flutter_app/domain/models/product.dart';
import 'package:my_flutter_app/presentation/pages/payment_page.dart';

class ProductCardListing extends StatelessWidget {
  final Product product;
  final bool showChatButton;

  const ProductCardListing({
    super.key,
    required this.product,
    this.showChatButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("\$${product.price.toStringAsFixed(2)}"),
            Text(product.description ?? 'No Description', 
              maxLines: 2, 
              overflow: TextOverflow.ellipsis
              ),
            const SizedBox(height: 8),
            Text(
              product.sellerPayPal != null
                  ? "Seller PayPal: ${product.sellerPayPal}"
                  : "Seller PayPal: Not Available",
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: product.sellerPayPal != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            product: product,
                            sellerPayPal: product.sellerPayPal!,
                            amount: product.price,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
