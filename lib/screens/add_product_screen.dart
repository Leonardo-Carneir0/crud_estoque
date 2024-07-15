import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key}); // Adiciona a chave ao construtor

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Erro ao selecionar imagem: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'), // Usar const
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'), // Usar const
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'), // Usar const
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Usar const
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Nome do Produto'), // Usar const
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _barcodeController,
                decoration: const InputDecoration(
                    labelText: 'Código de Barras'), // Usar const
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                    labelText: 'Quantidade'), // Usar const
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                    labelText: 'Preço (R\$)'), // Usar const
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Usar const
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : const Text('Nenhuma imagem selecionada.'), // Usar const
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera), // Usar const
                    label: const Text('Câmera'), // Usar const
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library), // Usar const
                    label: const Text('Galeria'), // Usar const
                  ),
                ],
              ),
              const SizedBox(height: 20), // Usar const
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                      id: DateTime.now().toString(),
                      name: _nameController.text,
                      barcode: _barcodeController.text.isEmpty
                          ? null
                          : _barcodeController.text,
                      quantity: _quantityController.text.isEmpty
                          ? null
                          : int.parse(_quantityController.text),
                      imagePath: _imageFile?.path,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                    );
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    try {
                      await productProvider.addProduct(newProduct);
                      if (!mounted)
                        return; // Verificar se o contexto ainda é válido
                      Navigator.pop(context, newProduct);
                    } catch (e) {
                      _showErrorDialog('Erro ao adicionar produto: $e');
                    }
                  }
                },
                child: const Text('Adicionar Produto'), // Usar const
              ),
            ],
          ),
        ),
      ),
    );
  }
}
