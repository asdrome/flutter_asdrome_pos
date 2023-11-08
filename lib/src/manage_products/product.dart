import 'package:json_annotation/json_annotation.dart';
import "package:pocketbase/pocketbase.dart";

part 'product.g.dart';

@JsonSerializable()
class Product {

  late String id;
  late String name;
  late String collectionName;
  late String brand;
  @JsonKey(name: 'image_src')
  late String imageSrc;
  late double price;
  late double discount;

  Product({
    this.id = "",
    this.name = "",
    this.collectionName = "",
    this.brand = "",
    this.imageSrc = "",
    this.price = 0.0,
    this.discount = 0.0
  });

  
  /// Creates a new Product instance form the provided RecordModel.
  factory Product.fromRecord(RecordModel record) => Product.fromJson(record.toJson());

  /// Connect the generated [_$Product] function to the `fromJson` factory.
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  /// Connect the generated [_$Product] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}