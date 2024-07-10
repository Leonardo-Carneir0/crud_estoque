import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  ProductTile({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.imagePath != null && product.imagePath!.isNotEmpty
          ? Image.file(File(product.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
          : null,
      title: Text(
        'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      subtitle: Text(product.name),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
