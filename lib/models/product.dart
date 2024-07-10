class Product {
  final String id;
  final String name;
  final String? barcode;
  final int? quantity;
  final String? imagePath;

  Product({
    required this.id,
    required this.name,
    this.barcode,
    this.quantity,
    this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      barcode: json['barcode'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'quantity': quantity,
      'imagePath': imagePath,
    };
  }
}
