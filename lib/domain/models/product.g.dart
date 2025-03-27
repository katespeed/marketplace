// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      sellerId: json['sellerId'] as String?,
      buyerId: json['buyerId'] as String?,
      sellerImageUrl: json['sellerImageUrl'] as String?,
      sellerName: json['sellerName'] as String?,
      rentalPrice: (json['rentalPrice'] as num?)?.toDouble(),
      description: json['description'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      size: json['size'] as String?,
      color: json['color'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      isAvailable: json['isAvailable'] as bool?,
      saleEndDate: json['saleEndDate'] == null
          ? null
          : DateTime.parse(json['saleEndDate'] as String),
      brand: json['brand'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrls': instance.imageUrls,
      'sellerId': instance.sellerId,
      'buyerId': instance.buyerId,
      'sellerImageUrl': instance.sellerImageUrl,
      'sellerName': instance.sellerName,
      'rentalPrice': instance.rentalPrice,
      'description': instance.description,
      'categories': instance.categories,
      'size': instance.size,
      'color': instance.color,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'isAvailable': instance.isAvailable,
      'saleEndDate': instance.saleEndDate?.toIso8601String(),
      'brand': instance.brand,
    };
