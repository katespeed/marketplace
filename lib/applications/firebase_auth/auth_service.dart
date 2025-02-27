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
    return authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    return authRepository.signOut();
  }

  Future<void> deleteAccount({required String password}) async {
    return authRepository.deleteAccount(password: password);
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await authRepository.auth.sendPasswordResetEmail(email: email);
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }
}
