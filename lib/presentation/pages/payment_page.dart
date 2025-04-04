import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_flutter_app/providers/product_provider.dart';
import 'package:my_flutter_app/domain/models/product.dart';

class PaymentPage extends StatelessWidget {
  final Product product;
  final double amount;
  final String sellerPayPal;

  const PaymentPage({
    super.key,
    required this.product,
    required this.amount,
    required this.sellerPayPal,
  });

  void _proceedToPay(BuildContext context) {
    final String payPalUrl = "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick"
        "&business=$sellerPayPal"
        "&amount=$amount"
        "&currency_code=USD"
        "&item_name=${Uri.encodeComponent(product.name)}";

    launchUrl(Uri.parse(payPalUrl), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pay \$${amount.toStringAsFixed(2)} to $sellerPayPal",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _proceedToPay(context),
              child: const Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
    );
  }
}