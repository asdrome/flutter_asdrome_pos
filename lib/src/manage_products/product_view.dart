import 'package:flutter/material.dart';
import 'product.dart';
import 'products_controller.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Elevación del card
      margin: const EdgeInsets.all(10), // Márgenes del card
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Proporción para hacer la tarjeta más ancha
              child: Image.network(
                product.imageSrc,
                fit: BoxFit.cover, // Ajuste de la imagen
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Marca: ${product.brand}'),
            Text('ID: ${product.id}'),
            Text('Colección: ${product.collectionName}'),
            Text(
                'Precio: \$${product.price.toStringAsFixed(2)}'), // Formatea el precio con dos decimales
            Text(
                'Descuento: ${product.discount.toStringAsFixed(2)}%'), // Formatea el descuento con dos decimales
          ],
        ),
      ),
    );
  }
}

class ProductGridView extends StatefulWidget {
  final String collectionName;

  const ProductGridView({super.key, required this.collectionName});
  static const routeName = '/products';

  @override
  ProductGridViewState createState() => ProductGridViewState();
}

class ProductGridViewState extends State<ProductGridView> {
  int _currentPage = 1;
  final int _itemsPerPage = 20; // Número de productos por página
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Número de columnas
        ),
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