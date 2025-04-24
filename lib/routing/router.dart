import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/pages/home.dart';
import 'package:my_flutter_app/presentation/pages/not_found.dart';
import 'package:my_flutter_app/presentation/pages/payment.dart';
import 'package:my_flutter_app/presentation/pages/product_detail.dart';
import 'package:my_flutter_app/presentation/pages/product_list.dart';
import 'package:my_flutter_app/presentation/pages/profile.dart';
import 'package:my_flutter_app/domain/models/product.dart';

import '../presentation/pages/upload_product.dart';

final router = GoRouter(
  initialLocation: '/home',
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/product-list',
      builder: (context, state) => const ProductListPage(),
    ),
    GoRoute(
      path: '/product-detail',
      builder: (context, state) => ProductDetailPage(
        product: state.extra as Product,
      ),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentPage(),
    ),
    GoRoute(
      path: '/upload_product',
      builder: (context, state) => const UploadProductPage(),
    ),
  ],
);
