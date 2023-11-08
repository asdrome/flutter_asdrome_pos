import 'package:flutter/material.dart';
import 'package:asdrome_pos/src/manage_products/product.dart';
import 'package:asdrome_pos/src/manage_products/products_controller.dart';

class AddProductView extends StatefulWidget {
  final ProductsController controller;

  const AddProductView({super.key, required this.controller});

  static const routeName = '/add';

  @override
  AddProductViewState createState() => AddProductViewState();
}

class AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  late Product _product;
  final List<String> categorias = ['cuidados_diarios', 'maquillaje', 'perfumeria'];
  String _selectedCategoria = 'cuidados_diarios'; // Valor inicial


  @override
  void initState() {
    super.initState();
    _product = Product(); // Inicializar el producto vacío
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.controller.addProduct(_product);
      /* Navigator.pop(context); */ // Cerrar la pantalla de agregar producto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'Marca'), // Cambiado de labelText a hintText
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la marca';
                  }
                  return null;
                },
                onSaved: (value) => _product.brand = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nombre'), // Cambiado de labelText a hintText
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre';
                  }
                  return null;
                },
                onSaved: (value) => _product.name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'URL de la imagen'), // Cambiado de labelText a hintText
                onSaved: (value) => _product.imageSrc = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Precio'), // Cambiado de labelText a hintText
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el precio';
                  }
                  return null;
                },
                onSaved: (value) => _product.price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Descuento'), // Cambiado de labelText a hintText
                keyboardType: TextInputType.number,
                onSaved: (value) => _product.discount = double.parse(value!),
              ),
              const SizedBox(height: 20),
              // Campo de selección de lista desplegable
              DropdownButtonFormField<String>(
                value: _selectedCategoria,
                items: categorias.map((String categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategoria = newValue!;
                  });
                },
                onSaved: (value) => _product.collectionName = value!,
                decoration: const InputDecoration(labelText: 'Categoría'), // Etiqueta del campo
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
