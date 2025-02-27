import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// 認証関連のリポジトリプロバイダー
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(FirebaseAuth.instance);

/// 認証関連のリポジトリ
class AuthRepository {
  /// init
  AuthRepository(this.auth);

  /// Firebase Auth
  final FirebaseAuth auth;

  /// 現在のユーザー
  User? get authUser => auth.currentUser;

  /// ユーザーの認証状態を監視する
  Stream<User?> authStateChanges() => auth.authStateChanges();

  /// メールアドレスとパスワードでログイン
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final user = auth.currentUser;
      if (user == null) return false;
      final idTokenResult = await user.getIdTokenResult(true);
      return idTokenResult.claims?['admin'] == true;
    } catch (e) {
      rethrow;
    }
  }

  /// ユーザーが管理者かどうかを判定する
  Future<bool> isAdmin(User? user) async {
    try{
      if (user != null) {
        await user.getIdTokenResult(true).then((idTokenResult) {
          if(idTokenResult.claims?['admin'] == true){
            return true;
          }
        });
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  /// サインアウト
  Future<void> signOut() async {
    await auth.signOut();
  }
}
