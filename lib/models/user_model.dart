// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String image;
  String name;
  String email;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
  });

  Product copyWith({
    String? id,
    String? image,
    String? name,
    String? email,
  }) =>
      Product(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
      };
}
