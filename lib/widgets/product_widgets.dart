import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imagePath;

  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? Image.file(
      File(imagePath!),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    )
        : Container();
  }
}

class ProductDetailText extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle style;

  const ProductDetailText({
    super.key,
    required this.label,
    required this.value,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value',
          style: style,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
