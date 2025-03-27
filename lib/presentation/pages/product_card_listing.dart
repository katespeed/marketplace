import 'package:flutter/material.dart';
import 'package:my_flutter_app/providers/product_provider.dart';
import 'package:my_flutter_app/presentation/pages/payment_page.dart';

class ProductCardListing extends StatelessWidget {
  final Product product;

  const ProductCardListing({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("\$${product.price.toStringAsFixed(2)}"),
            Text(product.description,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Text(
              product.sellerPayPalEmail != null
                  ? "Seller PayPal: ${product.sellerPayPalEmail}"
                  : "Seller PayPal: Not Available",
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: product.sellerPayPalEmail != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            product: product,
                            sellerPayPal: product.sellerPayPalEmail!,
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
