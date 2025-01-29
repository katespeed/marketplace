import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/pages/home.dart';
import 'package:my_flutter_app/presentation/pages/login.dart';
import 'package:my_flutter_app/presentation/pages/not_found.dart';
import 'package:my_flutter_app/presentation/pages/payment.dart';
import 'package:my_flutter_app/presentation/pages/product_detail.dart';
import 'package:my_flutter_app/presentation/pages/product_list.dart';
import 'package:my_flutter_app/presentation/pages/profile.dart';

final router = GoRouter(
  initialLocation: '/login',
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
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
      builder: (context, state) => const ProductDetailPage(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentPage(),
    ),
  ],
);
