import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/product_list_screen.dart';
import 'screens/search_product_screen.dart';
import 'screens/add_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Estoque de Loja',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:
            const ProductListScreen(), // Usar const para melhorar o desempenho
        routes: {
          '/add-product': (context) => const AddProductScreen(), // Usar const
          '/search-product': (context) =>
              const SearchProductScreen(), // Usar const
        },
      ),
    );
  }
}
