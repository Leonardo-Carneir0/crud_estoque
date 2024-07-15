import 'package:flutter/material.dart';
import 'package:gerenciador_mercadorias/widgets/product_tile.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import 'edit_product_screen.dart';
import 'add_product_screen.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

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
      body: products.isEmpty
          ? const Center(child: Text('Nenhum produto adicionado.'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductTile(
                  product: product,
                  onDelete: () => productProvider.deleteProduct(product.id),
                  onEdit: () async {
                    final updatedProduct = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProductScreen(product: product),
                      ),
                    );

                    if (updatedProduct != null) {
                      productProvider.updateProduct(updatedProduct);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
          if (result != null) {
            productProvider.addProduct(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
