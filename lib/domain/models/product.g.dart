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
      imagePath: json['imagePath'] as String?,
      sellerImageUrl: json['sellerImageUrl'] as String?,
      sellerName: json['sellerName'] as String?,
      description: json['description'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      size: json['size'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      saleEndDate: json['saleEndDate'] == null
          ? null
          : DateTime.parse(json['saleEndDate'] as String),
      sellerPayPal: json['sellerPayPal'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrls': instance.imageUrls,
      'sellerId': instance.sellerId,
      'buyerId': instance.buyerId,
      'imagePath': instance.imagePath,
      'sellerImageUrl': instance.sellerImageUrl,
      'sellerName': instance.sellerName,
      'description': instance.description,
      'categories': instance.categories,
      'size': instance.size,
      'isAvailable': instance.isAvailable,
      'saleEndDate': instance.saleEndDate?.toIso8601String(),
      'sellerPayPal': instance.sellerPayPal,
      'createdAt': instance.createdAt,
    };
