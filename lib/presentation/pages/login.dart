import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:my_flutter_app/providers/text_editing_controllers.dart';

import '../controller/forgot_password_controller.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

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

    //final passwordVisible = useState(false);
    final passwordVisible = ref.watch(passwordVisibilityProvider);

    useEffect(() {
      final subscription = authService.authStateChanges().listen((user) {
        if (user != null) {
          context.go('/home');
        }
      });

      return subscription.cancel;
    }, []);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      try {
        if (isLogin.value) {
          authService.signInWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );
        } else {
          authService.signUp(
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

    return Scaffold(
      body: Padding( //Left justify content
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 512), //padding on horizontal borders
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLogin.value ? 'Login' : 'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                if (!isLogin.value) 
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
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
                  decoration: InputDecoration(
                    labelText: 'user@university.edu',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
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
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[50]!),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                    //Show and hide password button
                    suffixIcon: TextButton(
                      onPressed: () => ref.read(passwordVisibilityProvider.notifier).state = !passwordVisible,
                      child: Text(
                        passwordVisible ? 'Hide Password' : 'Show Password', //toggle text
                      ),
                    ),
                  ),
                  obscureText: !passwordVisible, //toggle obscuring the password
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
  }
}


