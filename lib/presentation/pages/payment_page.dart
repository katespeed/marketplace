import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatelessWidget {
  final String sellerPayPal;
  final double amount;

  const PaymentPage(
      {required this.sellerPayPal, required this.amount, Key? key})
      : super(key: key);

  void _proceedToPay(BuildContext context) {
    String payPalUrl = "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick"
        "&business=$sellerPayPal"
        "&amount=$amount"
        "&currency_code=USD"
        "&item_name=Marketplace Purchase";
    launch(payPalUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Paying to: $sellerPayPal",
                style: const TextStyle(fontSize: 18)),
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
