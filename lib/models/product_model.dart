// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String name;
  String image;
  String description;
  String status;
  int price;
  bool isFavourite;

  Product({
    required this.status,
    required this.description,
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.isFavourite,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        isFavourite: json["isFavourite"],
        status: json["status"],
        image: json["image"],
        description: json['description'],
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "description": description,
        "status": status,
        "isFavourite": isFavourite,
      };
}
