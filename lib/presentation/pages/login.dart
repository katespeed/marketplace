import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/providers/text_editing_controllers.dart';

import '../controller/forgot_password_controller.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLogin = useState(true);
    
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final usernameController = ref.watch(usernameControllerProvider);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      try {
        if (isLogin.value) {
          await ref.read(authProvider.notifier).signIn(
                email: emailController.text,
                password: passwordController.text,
              );
        } else {
          await ref.read(authProvider.notifier).signUp(
                email: emailController.text,
                password: passwordController.text,
                username: usernameController.text,
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

    ref.listen(authProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          context.go('/home');
        }
      });
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin.value ? 'Login' : 'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                if (!isLogin.value)
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Forgot Password Button
                ElevatedButton(
                  onPressed: () {
                    ForgotPasswordController().showForgotPasswordDialog(context, ref);
                  },
                  child: const Text("Forgot Password?"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submit,
                  child: Text(isLogin.value ? 'Login' : 'Create Account'),
                ),
                TextButton(
                  onPressed: () {
                    isLogin.value = !isLogin.value;
                  },
                  child: Text(isLogin.value ? 'Create an account' : 'Back to login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


