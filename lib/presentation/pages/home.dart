import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';
import 'package:my_flutter_app/data/mock/featured_products.dart';
import 'package:my_flutter_app/presentation/components/grids/featured_products_grid.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: Container(
                  constraints: BoxConstraints(),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset(
                    'assets/home_image.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      CustomButton(
                        backgroundColor: Colors.grey,
                        text: 'Proceed to Checkout',
                        onPressed: () {
                          context.push('/forgot-password');
                        },
                      ),
                      CustomButton(
                        backgroundColor: Colors.grey,
                        onPressed: () {
                          context.push('/product-list');
                        },
                        text: 'Go to Product List',
                      ),
                      CustomButton(
                        backgroundColor: Colors.grey,
                        onPressed: () {
                          context.push('/payment');
                        },
                        text: 'Go to Payment',
                      ),
                      CustomButton(
                        backgroundColor: Colors.grey,
                        onPressed: () {
                          context.push('/product-detail');
                        },
                        text: 'Go to Product Detail',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Featured Items',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FeaturedProductsGrid(products: mockFeaturedProducts),
            ],
          ),
        ),
      ),
    );
  }
}