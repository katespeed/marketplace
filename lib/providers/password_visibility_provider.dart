//PasswordVisibility_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_visibility_provider.g.dart';

@riverpod
class PasswordVisibility extends _$PasswordVisibility {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}