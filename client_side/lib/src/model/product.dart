// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.quantity,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  int quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        description: json["description"],
        price: double.parse(json["price"]),
        categoryId: json["category_id"] is String
            ? int.parse(json["category_id"])
            : json["category_id"],
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "quantity": quantity,
      };
}
