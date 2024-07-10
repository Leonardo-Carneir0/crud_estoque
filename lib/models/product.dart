class Product {
  final String id;
  final String name;
  final String? barcode;
  final int? quantity;
  final String? imagePath;
  final double? price;

  Product({
    required this.id,
    required this.name,
    this.barcode,
    this.quantity,
    this.imagePath,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      barcode: json['barcode'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'quantity': quantity,
      'imagePath': imagePath,
      'price': price,
    };
  }
}
