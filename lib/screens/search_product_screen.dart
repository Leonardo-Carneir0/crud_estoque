import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/product.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key}); // Adiciona a chave ao construtor

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  void _searchProducts(String query) async {
    final results = await _databaseService.searchProducts(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Produto'), // Usar const
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Usar const
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por nome ou código de barras',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search), // Usar const
                  onPressed: () {
                    _searchProducts(_searchController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20), // Usar const
            _searchResults.isEmpty
                ? const Text('Nenhum resultado encontrado.') // Usar const
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Usar const
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                      'Código de Barras: ${product.barcode ?? 'N/A'}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
