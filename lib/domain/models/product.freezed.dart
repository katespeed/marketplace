// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  String? get sellerId => throw _privateConstructorUsedError;
  String? get buyerId => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  String? get sellerImageUrl => throw _privateConstructorUsedError;
  String? get sellerName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  bool? get isAvailable => throw _privateConstructorUsedError;
  DateTime? get saleEndDate => throw _privateConstructorUsedError;
  String? get sellerPayPal => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      List<String> imageUrls,
      String? sellerId,
      String? buyerId,
      String? imagePath,
      String? sellerImageUrl,
      String? sellerName,
      String? description,
      List<String>? categories,
      String? size,
      bool? isAvailable,
      DateTime? saleEndDate,
      String? sellerPayPal,
      String? createdAt});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrls = null,
    Object? sellerId = freezed,
    Object? buyerId = freezed,
    Object? imagePath = freezed,
    Object? sellerImageUrl = freezed,
    Object? sellerName = freezed,
    Object? description = freezed,
    Object? categories = freezed,
    Object? size = freezed,
    Object? isAvailable = freezed,
    Object? saleEndDate = freezed,
    Object? sellerPayPal = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      buyerId: freezed == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerImageUrl: freezed == sellerImageUrl
          ? _value.sellerImageUrl
          : sellerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleEndDate: freezed == saleEndDate
          ? _value.saleEndDate
          : saleEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sellerPayPal: freezed == sellerPayPal
          ? _value.sellerPayPal
          : sellerPayPal // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      List<String> imageUrls,
      String? sellerId,
      String? buyerId,
      String? imagePath,
      String? sellerImageUrl,
      String? sellerName,
      String? description,
      List<String>? categories,
      String? size,
      bool? isAvailable,
      DateTime? saleEndDate,
      String? sellerPayPal,
      String? createdAt});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrls = null,
    Object? sellerId = freezed,
    Object? buyerId = freezed,
    Object? imagePath = freezed,
    Object? sellerImageUrl = freezed,
    Object? sellerName = freezed,
    Object? description = freezed,
    Object? categories = freezed,
    Object? size = freezed,
    Object? isAvailable = freezed,
    Object? saleEndDate = freezed,
    Object? sellerPayPal = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      buyerId: freezed == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerImageUrl: freezed == sellerImageUrl
          ? _value.sellerImageUrl
          : sellerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleEndDate: freezed == saleEndDate
          ? _value.saleEndDate
          : saleEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sellerPayPal: freezed == sellerPayPal
          ? _value.sellerPayPal
          : sellerPayPal // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {required this.id,
      required this.name,
      required this.price,
      required final List<String> imageUrls,
      this.sellerId,
      this.buyerId,
      this.imagePath,
      this.sellerImageUrl,
      this.sellerName,
      this.description,
      final List<String>? categories,
      this.size,
      this.isAvailable,
      this.saleEndDate,
      this.sellerPayPal,
      this.createdAt})
      : _imageUrls = imageUrls,
        _categories = categories;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String? sellerId;
  @override
  final String? buyerId;
  @override
  final String? imagePath;
  @override
  final String? sellerImageUrl;
  @override
  final String? sellerName;
  @override
  final String? description;
  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? size;
  @override
  final bool? isAvailable;
  @override
  final DateTime? saleEndDate;
  @override
  final String? sellerPayPal;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imageUrls: $imageUrls, sellerId: $sellerId, buyerId: $buyerId, imagePath: $imagePath, sellerImageUrl: $sellerImageUrl, sellerName: $sellerName, description: $description, categories: $categories, size: $size, isAvailable: $isAvailable, saleEndDate: $saleEndDate, sellerPayPal: $sellerPayPal, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.sellerImageUrl, sellerImageUrl) ||
                other.sellerImageUrl == sellerImageUrl) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.saleEndDate, saleEndDate) ||
                other.saleEndDate == saleEndDate) &&
            (identical(other.sellerPayPal, sellerPayPal) ||
                other.sellerPayPal == sellerPayPal) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      const DeepCollectionEquality().hash(_imageUrls),
      sellerId,
      buyerId,
      imagePath,
      sellerImageUrl,
      sellerName,
      description,
      const DeepCollectionEquality().hash(_categories),
      size,
      isAvailable,
      saleEndDate,
      sellerPayPal,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {required final String id,
      required final String name,
      required final double price,
      required final List<String> imageUrls,
      final String? sellerId,
      final String? buyerId,
      final String? imagePath,
      final String? sellerImageUrl,
      final String? sellerName,
      final String? description,
      final List<String>? categories,
      final String? size,
      final bool? isAvailable,
      final DateTime? saleEndDate,
      final String? sellerPayPal,
      final String? createdAt}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  List<String> get imageUrls;
  @override
  String? get sellerId;
  @override
  String? get buyerId;
  @override
  String? get imagePath;
  @override
  String? get sellerImageUrl;
  @override
  String? get sellerName;
  @override
  String? get description;
  @override
  List<String>? get categories;
  @override
  String? get size;
  @override
  bool? get isAvailable;
  @override
  DateTime? get saleEndDate;
  @override
  String? get sellerPayPal;
  @override
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
