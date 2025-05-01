import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_app/domain/models/product.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String uuid,
    required String id,
    required String name,
    required String email,
    required DateTime createdAt,
    String? paypalEmail,
    String? profileImagePath,
    String? bio,
    List<Product>? sellProducts,
    List<Product>? buyProducts,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
} 