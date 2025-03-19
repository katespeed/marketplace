import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/data/firebase_auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.read(authRepositoryProvider));
}

class AuthService {
  AuthService(this.authRepository);

  final AuthRepository authRepository;
  User? get authUser => authRepository.authUser;

  Stream<User?> authStateChanges() => authRepository.authStateChanges();

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    return authRepository.signUp(
      email: email,
      password: password,
      username: username,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await authRepository.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No account exists with this email. Please check your email or create a new account.';
        case 'wrong-password':
          throw 'Incorrect password. Please try again.';
        case 'invalid-email':
          throw 'Invalid email format. Please enter a valid email address.';
        case 'user-disabled':
          throw 'This account has been disabled. Please contact support.';
        case 'too-many-requests':
          throw 'Too many failed login attempts. Please try again later.';
        default:
          throw 'Login failed. Please try again.';
      }
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }

  Future<void> signOut() async {
    return authRepository.signOut();
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      await authRepository.deleteAccount(password: password);
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await authRepository.auth.sendPasswordResetEmail(email: email);
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }
}
