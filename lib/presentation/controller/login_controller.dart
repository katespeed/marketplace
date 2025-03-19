import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';

final loginControllerProvider = Provider((ref) => LoginController(ref));

class LoginController {
  final ProviderRef _ref;

  LoginController(this._ref);

  Future<void> submit({
    required bool isLogin,
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final authService = _ref.read(authServiceProvider);
      
      if (isLogin) {
        await authService.signInWithEmailAndPassword(
          email,
          password,
        );
      } else {
        await authService.signUp(
          email: email,
          password: password,
          username: username,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
} 