import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/components/cards/product_card_listing.dart';
import 'package:my_flutter_app/domain/models/product.dart'; 



class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
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
      appBar: AppBar(title: Text("My Uploads")),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
          .collection('products')
          .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(child: Text('You have no uploads.'));
          }

          final products = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Product.fromJson({
              ...data,
              'id': doc.id,
              'name': data['title'],
              'imageUrls': data['imageUrls'] ?? [],
            });
          }).toList();

          final liveListings = products.where((p) => p.isAvailable == true).toList();
          final soldItems = products.where((p) => p.isAvailable == false).toList();

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if(liveListings.isNotEmpty) ...[
                Text("Live Listings", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...liveListings.map((product) => ProductCardListing(
                  product: product,
                  showChatButton: false,
                )),
                const SizedBox(height: 24),
              ],
              if(soldItems.isNotEmpty) ...[
                Text("Sold Items", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...soldItems.map((product) => ProductCardListing(
                  product: product,
                  showChatButton: false,
                )),
              ],
            ],
          );
        }
      )
    );
  }
}