import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'edit_product_screen.dart';
import '../services/database_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final databaseService = DatabaseService();
              await databaseService.deleteProduct(product.id);
              Navigator.pop(context); // Volta para a lista de produtos
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.imagePath != null
                ? Image.file(
                    File(product.imagePath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  )
                : Container(),
            const SizedBox(height: 16),
            Text(
              'Nome: ${product.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Preço: R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Código de Barras: ${product.barcode ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Quantidade: ${product.quantity ?? 0}',
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
