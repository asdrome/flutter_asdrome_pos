import 'package:asdrome_pos/src/manage_products/product.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductsController with ChangeNotifier {
  final PocketBase _pb = PocketBase('https://asdrome-pos-pb.pockethost.io');

  ProductsController();

  Future<bool> addProduct(Product product) async {
    try {

      await _pb.collection(product.collectionName).create(body: product.toJson());

      // Informa a los oyentes (listeners) que ha ocurrido un cambio.
      notifyListeners();

      // Verifica si el producto se agregó correctamente basándose en el objeto record.
      return true;
    } catch (error) {
      // Maneja cualquier error que ocurra durante la operación y devuelve false.
      return false;
    }
  }

Future<List<Product>> listProducts(String collectionName, {
  int page = 1,
  int perPage = 50,
  String filter = '',
}) async {
  try {
    final resultList = await _pb.collection(collectionName).getList(
      page: page,
      perPage: perPage,
      filter: filter,
    );

    // Convierte ResultList a una lista de RecordModel
    List<RecordModel> recordsList = resultList.items;

    // Mapea los resultados de RecordModel a objetos Product
    List<Product> products = recordsList.map(Product.fromRecord).toList();

    // Informa a los oyentes (listeners) que ha ocurrido un cambio.
    notifyListeners();

    // Retorna la lista de productos obtenidos.
    return products;
  } catch (error) {
    // Maneja cualquier error que ocurra durante la operación.
    throw Exception('Error al listar productos: $error');
  }
}

Future<List<Product>> listAllProducts(String collectionName, {
    String sort = '-created',
  }) async {
    try {
      final resultList = await _pb.collection(collectionName).getFullList(
        sort: sort,
      );

      // Mapea los resultados de RecordModel a objetos Product
      List<Product> products = resultList.map(Product.fromRecord).toList();

      // Informa a los oyentes (listeners) que ha ocurrido un cambio.
      notifyListeners();

      // Retorna la lista completa de productos obtenidos.
      return products;
    } catch (error) {
      // Maneja cualquier error que ocurra durante la operación.
      throw Exception('Error al listar todos los productos: $error');
    }
  }
}
