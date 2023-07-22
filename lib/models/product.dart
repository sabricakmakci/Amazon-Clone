// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double quantity;
  final String category;
  final double price;
  final List<String> images;
  final String? id;
  final String? userId;
  const Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    required this.images,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'category': category,
      'price': price,
      'images': images,
      'id': id,
      'userId': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: (map["name"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      quantity: (map["quantity"] ?? 0.0) as double,
      category: (map["category"] ?? '') as String,
      price: (map["price"] ?? 0.0) as double,
      images: List<String>.from(
        ((map['images'] ?? const <String>[]) as List<String>),
      ),
      id: map['id'] != null ? map["id"] ?? '' : null,
      userId: map['userId'] != null ? map["userId"] ?? '' : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
