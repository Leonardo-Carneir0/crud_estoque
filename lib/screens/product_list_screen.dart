import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final DatabaseService _databaseService = DatabaseService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final products = await _databaseService.getProducts();
    setState(() {
      _products = products;
    });
  }

  void _deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
    _fetchProducts();
  }

  Future<void> _editProduct(Product product) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        final index = _products.indexWhere((p) => p.id == updatedProduct.id);
        if (index != -1) {
          _products[index] = updatedProduct;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque de Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search-product');
            },
          ),
        ],
      ),
      body: _products.isEmpty
          ? const Center(child: Text('Nenhum produto adicionado.'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductTile(
                  product: product,
                  onDelete: () => _deleteProduct(product.id),
                  onEdit: () => _editProduct(product),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-product').then((_) {
            _fetchProducts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
