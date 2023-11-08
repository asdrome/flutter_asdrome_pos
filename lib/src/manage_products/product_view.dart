import 'package:flutter/material.dart';
import 'product.dart';
import 'products_controller.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Elevación del card
      margin: EdgeInsets.all(10), // Márgenes del card
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${product.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Marca: ${product.brand}'),
            Text('ID: ${product.id}'),
            Text('Colección: ${product.collectionName}'),
            Image.network(
              product.imageSrc,
              height: 150, // Altura de la imagen
              width: double.infinity, // Ancho de la imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
            SizedBox(height: 8),
            Text('Precio: \$${product.price.toStringAsFixed(2)}'), // Formatea el precio con dos decimales
            Text('Descuento: ${product.discount.toStringAsFixed(2)}%'), // Formatea el descuento con dos decimales
          ],
        ),
      ),
    );
  }
}

class ProductListView extends StatefulWidget {
  final String collectionName;

  const ProductListView({super.key, required this.collectionName});
  static const routeName = '/products';

  @override
  ProductListViewState createState() => ProductListViewState();
}

class ProductListViewState extends State<ProductListView> {
  int _currentPage = 1;
  final int _itemsPerPage = 10; // Número de productos por página
  List<Product> _products = [];
  final ProductsController _productsController = ProductsController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> products = await _productsController.listProducts(
        widget.collectionName,
        page: _currentPage,
        perPage: _itemsPerPage,
      );
      setState(() {
        _products = products;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrar un mensaje de error al usuario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: _products[index]);
        },
      ),
      // Agregar un botón para cargar más productos
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentPage++; // Cargar la siguiente página de productos
          });
          _loadProducts();
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
