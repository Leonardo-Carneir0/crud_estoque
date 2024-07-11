import 'package:flutter/material.dart';
import '../models/product.dart';
import 'edit_product_screen.dart';
import 'dart:io';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductScreen(product: product),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: 'edit',
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.imagePath != null
                ? Image.file(File(product.imagePath!))
                : Container(),
            SizedBox(height: 16),
            Text(
              'Nome: ${product.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Preço: R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Código de Barras: ${product.barcode ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Quantidade: ${product.quantity ?? 0}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
