import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search-product');
            },
          ),
        ],
      ),
      body: _products.isEmpty
          ? Center(child: Text('Nenhum produto adicionado.'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductTile(
                  product: product,
                  onDelete: () => _deleteProduct(product.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-product').then((_) {
            _fetchProducts();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
