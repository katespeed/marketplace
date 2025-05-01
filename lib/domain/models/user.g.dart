// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uuid: json['uuid'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      paypalEmail: json['paypalEmail'] as String?,
      profileImagePath: json['profileImagePath'] as String?,
      bio: json['bio'] as String?,
      sellProducts: (json['sellProducts'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      buyProducts: (json['buyProducts'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'paypalEmail': instance.paypalEmail,
      'profileImagePath': instance.profileImagePath,
      'bio': instance.bio,
      'sellProducts': instance.sellProducts,
      'buyProducts': instance.buyProducts,
    };
