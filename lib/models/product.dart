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
  const Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    required this.images,
    this.id,
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
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map["name"] ?? '',
      description: map["description"] ?? '',
      quantity: map["quantity"]?.toDouble() ?? 0.0,
      category: map["category"] ?? '',
      price: map["price"]?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
