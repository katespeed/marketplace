// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get uuid => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get paypalEmail => throw _privateConstructorUsedError;
  String? get profileImagePath => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<Product>? get sellProducts => throw _privateConstructorUsedError;
  List<Product>? get buyProducts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String uuid,
      String id,
      String name,
      String email,
      DateTime createdAt,
      String? paypalEmail,
      String? profileImagePath,
      String? bio,
      List<Product>? sellProducts,
      List<Product>? buyProducts});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? createdAt = null,
    Object? paypalEmail = freezed,
    Object? profileImagePath = freezed,
    Object? bio = freezed,
    Object? sellProducts = freezed,
    Object? buyProducts = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paypalEmail: freezed == paypalEmail
          ? _value.paypalEmail
          : paypalEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImagePath: freezed == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      sellProducts: freezed == sellProducts
          ? _value.sellProducts
          : sellProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      buyProducts: freezed == buyProducts
          ? _value.buyProducts
          : buyProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      String id,
      String name,
      String email,
      DateTime createdAt,
      String? paypalEmail,
      String? profileImagePath,
      String? bio,
      List<Product>? sellProducts,
      List<Product>? buyProducts});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? createdAt = null,
    Object? paypalEmail = freezed,
    Object? profileImagePath = freezed,
    Object? bio = freezed,
    Object? sellProducts = freezed,
    Object? buyProducts = freezed,
  }) {
    return _then(_$UserImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paypalEmail: freezed == paypalEmail
          ? _value.paypalEmail
          : paypalEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImagePath: freezed == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      sellProducts: freezed == sellProducts
          ? _value._sellProducts
          : sellProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      buyProducts: freezed == buyProducts
          ? _value._buyProducts
          : buyProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.uuid,
      required this.id,
      required this.name,
      required this.email,
      required this.createdAt,
      this.paypalEmail,
      this.profileImagePath,
      this.bio,
      final List<Product>? sellProducts,
      final List<Product>? buyProducts})
      : _sellProducts = sellProducts,
        _buyProducts = buyProducts;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String uuid;
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final DateTime createdAt;
  @override
  final String? paypalEmail;
  @override
  final String? profileImagePath;
  @override
  final String? bio;
  final List<Product>? _sellProducts;
  @override
  List<Product>? get sellProducts {
    final value = _sellProducts;
    if (value == null) return null;
    if (_sellProducts is EqualUnmodifiableListView) return _sellProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Product>? _buyProducts;
  @override
  List<Product>? get buyProducts {
    final value = _buyProducts;
    if (value == null) return null;
    if (_buyProducts is EqualUnmodifiableListView) return _buyProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(uuid: $uuid, id: $id, name: $name, email: $email, createdAt: $createdAt, paypalEmail: $paypalEmail, profileImagePath: $profileImagePath, bio: $bio, sellProducts: $sellProducts, buyProducts: $buyProducts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paypalEmail, paypalEmail) ||
                other.paypalEmail == paypalEmail) &&
            (identical(other.profileImagePath, profileImagePath) ||
                other.profileImagePath == profileImagePath) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality()
                .equals(other._sellProducts, _sellProducts) &&
            const DeepCollectionEquality()
                .equals(other._buyProducts, _buyProducts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      id,
      name,
      email,
      createdAt,
      paypalEmail,
      profileImagePath,
      bio,
      const DeepCollectionEquality().hash(_sellProducts),
      const DeepCollectionEquality().hash(_buyProducts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String uuid,
      required final String id,
      required final String name,
      required final String email,
      required final DateTime createdAt,
      final String? paypalEmail,
      final String? profileImagePath,
      final String? bio,
      final List<Product>? sellProducts,
      final List<Product>? buyProducts}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get uuid;
  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  DateTime get createdAt;
  @override
  String? get paypalEmail;
  @override
  String? get profileImagePath;
  @override
  String? get bio;
  @override
  List<Product>? get sellProducts;
  @override
  List<Product>? get buyProducts;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
