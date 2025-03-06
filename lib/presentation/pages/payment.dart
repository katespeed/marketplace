import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _paypalEmail;

  @override
  void initState() {
    super.initState();
    _fetchPayPalEmail();
  }

  /// Fetch current user's PayPal email from Firestore
  Future<void> _fetchPayPalEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && doc.data()?['paypalEmail'] != null) {
        setState(() {
          _paypalEmail = doc.data()?['paypalEmail'];
        });
      }
    }
  }

  /// Show a dialog to add PayPal email
  void _showAddPayPalDialog() {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Your PayPal Account"),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: "Enter PayPal Email"),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              String email = emailController.text.trim();
              if (email.isNotEmpty) {
                await _savePayPalEmail(email);
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  /// Save PayPal email to Firestore
  Future<void> _savePayPalEmail(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'paypalEmail': email,
      });

      setState(() {
        _paypalEmail = email;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PayPal account added successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: _showAddPayPalDialog,
            tooltip: "Add your seller PayPal account",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _paypalEmail != null
                  ? "Your PayPal: $_paypalEmail"
                  : "No PayPal account linked",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {}, // TODO: Add PayPal Payment Functionality Here
              child: Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
