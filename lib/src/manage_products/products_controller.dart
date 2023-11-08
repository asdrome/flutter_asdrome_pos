import 'package:asdrome_pos/src/manage_products/product.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductsController with ChangeNotifier {
  final PocketBase _pb = PocketBase('https://asdrome-pos-pb.pockethost.io');

  ProductsController();


  Future<void> addProduct(Product product) async {
    final body = <String, dynamic>{
      "brand": product.brand,
      "image_src": product.imageSrc,
      "name": product.name,
      "price": product.price,
      "discount": product.discount
    };

    final record = await _pb.collection(product.collectionName).create(body: body);

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }
}
