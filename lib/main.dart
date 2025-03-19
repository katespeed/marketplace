// Description: This code initializes a Flutter application with Firebase.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'routing/router.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FlutterError.onError = (FlutterErrorDetails details) {
    // アセットの読み込みエラーを無視
    if (details.exception.toString().contains('assets/assets/products')) {
      return;
    }
    // その他のエラーは通常通り処理
    FlutterError.presentError(details);
  };
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Students Marketplace',
      routerConfig: router,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
    );
  }
} 