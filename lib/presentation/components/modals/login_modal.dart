import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';
import 'package:my_flutter_app/presentation/components/text_form_field/custom_text_form_field.dart';
import 'package:my_flutter_app/providers/password_visibility_provider.dart';
import 'package:my_flutter_app/providers/text_editing_controllers.dart';
import 'package:my_flutter_app/presentation/controller/login_controller.dart';
import 'package:my_flutter_app/presentation/controller/forgot_password_controller.dart';

class LoginModal extends HookConsumerWidget {
  const LoginModal({super.key});

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
      final subscription = authService.userChanges().listen((user) {
        if (user != null && user.emailVerified) {
          Navigator.of(context).pop();
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
      }
    }

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              if (isLogin.value)
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
    );
  }
} 