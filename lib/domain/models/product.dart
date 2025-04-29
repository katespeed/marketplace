import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required List<String> imageUrls,
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
    String? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
} 