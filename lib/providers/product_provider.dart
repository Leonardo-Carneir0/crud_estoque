import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/database_service.dart';

class ProductProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await _databaseService.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _databaseService.insertProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _databaseService.updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
    await fetchProducts();
  }
}
