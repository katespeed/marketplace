import 'package:flutter/material.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('PaymentPage Page')),
    );
  }
}