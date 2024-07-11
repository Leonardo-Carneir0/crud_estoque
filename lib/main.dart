import 'package:flutter/material.dart';
import 'screens/product_list_screen.dart';
import 'screens/search_product_screen.dart';
import 'screens/add_product_screen.dart';
import 'screens/edit_product_screen.dart'; // Nova importação
import 'screens/product_detail_screen.dart'; // Nova importação

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estoque de Loja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductListScreen(),
      routes: {
        '/add-product': (context) => AddProductScreen(),
        '/search-product': (context) => SearchProductScreen(),
      },
    );
  }
}
