import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import 'edit_product_screen.dart';
import '../widgets/product_widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Produto'),
        content: const Text('Tem certeza que deseja excluir este produto?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              try {
                await productProvider.deleteProduct(product.id);
                if (!context.mounted) return;
                Navigator.pop(context, true);
              } catch (e) {
                _showErrorDialog(context, 'Erro ao excluir produto: $e');
              }
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(imagePath: product.imagePath),
            const SizedBox(height: 16),
            ProductDetailText(
              label: 'Nome',
              value: product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ProductDetailText(
              label: 'Preço',
              value: 'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(fontSize: 18),
            ),
            ProductDetailText(
              label: 'Código de Barras',
              value: product.barcode ?? 'N/A',
              style: const TextStyle(fontSize: 18),
            ),
            ProductDetailText(
              label: 'Quantidade',
              value: '${product.quantity ?? 0}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Editar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductScreen(product: product),
                  ),
                ).then((updatedProduct) {
                  if (updatedProduct != null) {
                    Navigator.pop(context, updatedProduct);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
