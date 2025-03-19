import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';
import 'package:my_flutter_app/presentation/controller/forgot_password_controller.dart';
import 'package:my_flutter_app/providers/password_visibility_provider.dart';
import 'package:my_flutter_app/providers/text_editing_controllers.dart';
import 'package:my_flutter_app/presentation/controller/login_controller.dart';
import 'package:my_flutter_app/presentation/components/text_form_field/custom_text_form_field.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLogin = useState(true);
    
    final authService = ref.watch(authServiceProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final usernameController = ref.watch(usernameControllerProvider);
    final passwordVisible = ref.watch(passwordVisibilityProvider);

    useEffect(() {
      final subscription = authService.authStateChanges().listen((user) {
        if (user != null) {
          context.go('/home');
        }
      });

      return subscription.cancel;
    }, []);

    Future<void> handleSubmit() async {
      if (!formKey.currentState!.validate()) return;

      try {
        await ref.read(loginControllerProvider).submit(
          isLogin: isLogin.value,
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
          context: context,
        );
      } catch (e) {
        if (!context.mounted) return;
        
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth > 1200 
              ? (constraints.maxWidth - 800) / 2
              : constraints.maxWidth > 600 
                  ? (constraints.maxWidth - 500) / 2 
                  : 16.0;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLogin.value ? 'Login' : 'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      if (!isLogin.value) 
                        CustomTextFormField(
                          controller: usernameController,
                          labelText: 'Username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                      
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: 'user@university.edu',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if(!value.contains('@smail.astate.edu')){
                            return 'Enter a valid A-State student email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        isPassword: true,
                        obscureText: !passwordVisible,
                        suffixIcon: TextButton(
                          onPressed: () => ref.read(passwordVisibilityProvider.notifier).toggle(),
                          child: Text(
                            passwordVisible ? 'Hide Password' : 'Show Password',
                          ),
                        ),
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
                      CustomButton(
                        text: "Forgot Password?",
                        onPressed: () {
                          ForgotPasswordController().showForgotPasswordDialog(context, ref);
                        },
                        backgroundColor: Colors.white,
                        textColor: Colors.blue,
                        height: 40,
                        borderRadius: 8.0,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: isLogin.value ? 'Login' : 'Create Account',
                        onPressed: handleSubmit,
                        backgroundColor: Colors.white,
                        textColor: Colors.blue,
                        height: 48,
                        borderRadius: 8.0,
                      ),
                      const SizedBox(height: 8),
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
        },
      ),
    );
  }
}


