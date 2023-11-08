// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      collectionName: json['collectionName'] as String? ?? "",
      brand: json['brand'] as String? ?? "",
      imageSrc: json['image_src'] as String? ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'collectionName': instance.collectionName,
      'brand': instance.brand,
      'image_src': instance.imageSrc,
      'price': instance.price,
      'discount': instance.discount,
    };
