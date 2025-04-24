import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/grids/featured_products_grid.dart';
import 'package:my_flutter_app/providers/product_provider.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:my_flutter_app/presentation/components/modals/login_modal.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productListProvider);
    final authService = ref.watch(authServiceProvider);

    // Show login modal if user is not logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authService.currentUser == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LoginModal(),
        );
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      constraints: const BoxConstraints(),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/home_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withAlpha((0.3 * 255).toInt()),
                                Colors.black.withAlpha((0.1 * 255).toInt()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Student Marketplace',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 3.0,
                            color: Colors.black.withAlpha((0.5 * 255).toInt()),
                          ),
                          Shadow(
                            offset: const Offset(-1, -1),
                            blurRadius: 1.0,
                            color: Colors.black.withAlpha((0.3 * 255).toInt()),
                          ),
                        ],
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Recently posted items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => context.push('/product-list'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              asyncProducts.when(
                data: (products) {
                  // Preload images
                  for (final product in products) {
                    if (product.imageUrls.isNotEmpty) {
                      try {
                        final imageUrl = product.imageUrls[0];
                        if (imageUrl.startsWith('http')) {
                          precacheImage(
                            NetworkImage(imageUrl),
                            context,
                          ).catchError((error) {
                            debugPrint('Failed to precache image: $error');
                          });
                        }
                      } catch (e) {
                        debugPrint('Error precaching image: $e');
                      }
                    }
                  }
                  return FeaturedProductsGrid(products: products);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text("Error loading products: $error"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
