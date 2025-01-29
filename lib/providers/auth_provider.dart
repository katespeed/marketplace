import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  final _auth = FirebaseAuth.instance;

  Future<void> _init() async {
    _auth.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      state = const AsyncValue.loading();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(username);
      state = AsyncValue.data(credential.user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncValue.loading();
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(credential.user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteAccount(String password) async {
    try {
      state = const AsyncValue.loading();
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');
      
      // ユーザーの再認証
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      
      // アカウント削除
      await user.delete();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
} 