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
  String? get sellerImageUrl => throw _privateConstructorUsedError;
  String? get sellerName => throw _privateConstructorUsedError;
  double? get rentalPrice => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get reviewCount => throw _privateConstructorUsedError;
  bool? get isAvailable => throw _privateConstructorUsedError;
  DateTime? get saleEndDate => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get sellerPayPal => throw _privateConstructorUsedError;

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
      String? sellerImageUrl,
      String? sellerName,
      double? rentalPrice,
      String? description,
      List<String>? categories,
      String? size,
      String? color,
      double? rating,
      int? reviewCount,
      bool? isAvailable,
      DateTime? saleEndDate,
      String? brand,
      String? sellerPayPal});
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
    Object? sellerImageUrl = freezed,
    Object? sellerName = freezed,
    Object? rentalPrice = freezed,
    Object? description = freezed,
    Object? categories = freezed,
    Object? size = freezed,
    Object? color = freezed,
    Object? rating = freezed,
    Object? reviewCount = freezed,
    Object? isAvailable = freezed,
    Object? saleEndDate = freezed,
    Object? brand = freezed,
    Object? sellerPayPal = freezed,
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
      sellerImageUrl: freezed == sellerImageUrl
          ? _value.sellerImageUrl
          : sellerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      rentalPrice: freezed == rentalPrice
          ? _value.rentalPrice
          : rentalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
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
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleEndDate: freezed == saleEndDate
          ? _value.saleEndDate
          : saleEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerPayPal: freezed == sellerPayPal
          ? _value.sellerPayPal
          : sellerPayPal // ignore: cast_nullable_to_non_nullable
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
      String? sellerImageUrl,
      String? sellerName,
      double? rentalPrice,
      String? description,
      List<String>? categories,
      String? size,
      String? color,
      double? rating,
      int? reviewCount,
      bool? isAvailable,
      DateTime? saleEndDate,
      String? brand,
      String? sellerPayPal});
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
    Object? sellerImageUrl = freezed,
    Object? sellerName = freezed,
    Object? rentalPrice = freezed,
    Object? description = freezed,
    Object? categories = freezed,
    Object? size = freezed,
    Object? color = freezed,
    Object? rating = freezed,
    Object? reviewCount = freezed,
    Object? isAvailable = freezed,
    Object? saleEndDate = freezed,
    Object? brand = freezed,
    Object? sellerPayPal = freezed,
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
      sellerImageUrl: freezed == sellerImageUrl
          ? _value.sellerImageUrl
          : sellerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      rentalPrice: freezed == rentalPrice
          ? _value.rentalPrice
          : rentalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
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
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleEndDate: freezed == saleEndDate
          ? _value.saleEndDate
          : saleEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerPayPal: freezed == sellerPayPal
          ? _value.sellerPayPal
          : sellerPayPal // ignore: cast_nullable_to_non_nullable
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
      this.sellerImageUrl,
      this.sellerName,
      this.rentalPrice,
      this.description,
      final List<String>? categories,
      this.size,
      this.color,
      this.rating,
      this.reviewCount,
      this.isAvailable,
      this.saleEndDate,
      this.brand,
      this.sellerPayPal})
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
  final String? sellerImageUrl;
  @override
  final String? sellerName;
  @override
  final double? rentalPrice;
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
  final String? color;
  @override
  final double? rating;
  @override
  final int? reviewCount;
  @override
  final bool? isAvailable;
  @override
  final DateTime? saleEndDate;
  @override
  final String? brand;
  @override
  final String? sellerPayPal;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imageUrls: $imageUrls, sellerId: $sellerId, buyerId: $buyerId, sellerImageUrl: $sellerImageUrl, sellerName: $sellerName, rentalPrice: $rentalPrice, description: $description, categories: $categories, size: $size, color: $color, rating: $rating, reviewCount: $reviewCount, isAvailable: $isAvailable, saleEndDate: $saleEndDate, brand: $brand, sellerPayPal: $sellerPayPal)';
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
            (identical(other.sellerImageUrl, sellerImageUrl) ||
                other.sellerImageUrl == sellerImageUrl) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.rentalPrice, rentalPrice) ||
                other.rentalPrice == rentalPrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.saleEndDate, saleEndDate) ||
                other.saleEndDate == saleEndDate) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.sellerPayPal, sellerPayPal) ||
                other.sellerPayPal == sellerPayPal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        price,
        const DeepCollectionEquality().hash(_imageUrls),
        sellerId,
        buyerId,
        sellerImageUrl,
        sellerName,
        rentalPrice,
        description,
        const DeepCollectionEquality().hash(_categories),
        size,
        color,
        rating,
        reviewCount,
        isAvailable,
        saleEndDate,
        brand,
        sellerPayPal
      ]);

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
      final String? sellerImageUrl,
      final String? sellerName,
      final double? rentalPrice,
      final String? description,
      final List<String>? categories,
      final String? size,
      final String? color,
      final double? rating,
      final int? reviewCount,
      final bool? isAvailable,
      final DateTime? saleEndDate,
      final String? brand,
      final String? sellerPayPal}) = _$ProductImpl;

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
  String? get sellerImageUrl;
  @override
  String? get sellerName;
  @override
  double? get rentalPrice;
  @override
  String? get description;
  @override
  List<String>? get categories;
  @override
  String? get size;
  @override
  String? get color;
  @override
  double? get rating;
  @override
  int? get reviewCount;
  @override
  bool? get isAvailable;
  @override
  DateTime? get saleEndDate;
  @override
  String? get brand;
  @override
  String? get sellerPayPal;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
