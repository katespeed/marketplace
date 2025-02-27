import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/data/firebase_auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

/// 認証関連のサービスプロバイダー
@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.read(authRepositoryProvider));
}

/// 認証関連のサービス
class AuthService {
  /// init
  AuthService(this.authRepository);

  /// 認証リポジトリ
  final AuthRepository authRepository;

  /// 現在のユーザー
  User? get authUser => authRepository.authUser;

  /// ユーザーの認証状態を監視
  Stream<User?> authStateChanges() => authRepository.authStateChanges();

  /// メールアドレスとパスワードでログイン
  /// ログイン成功時に管理者かどうかを返す
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    return authRepository.signInWithEmailAndPassword(email, password);
  }

  /// サインアウト
  Future<void> signOut() async {
    return authRepository.signOut();
  }
}
