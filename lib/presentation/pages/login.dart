import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameController = useTextEditingController();
    final isLogin = useState(true);

    useEffect(() {
      return () {
        emailController.dispose();
        passwordController.dispose();
        usernameController.dispose();
      };
    }, []);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

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
    }

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            context.go('/home');
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
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