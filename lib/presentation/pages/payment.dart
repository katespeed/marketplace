import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/cards/product_card_listing.dart';
import 'package:my_flutter_app/domain/models/product.dart'; 



class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
              'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
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