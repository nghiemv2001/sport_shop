// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String description;
  String id;
  String image;
  bool isFavourite;
  String name;
  String price;
  String status;
  int? qty;

  Product({
    required this.description,
    required this.id,
    required this.image,
    required this.isFavourite,
    required this.name,
    required this.price,
    required this.status,
    required this.qty,
  });

  Product copyWith({
    String? description,
    String? id,
    String? image,
    bool? isFavourite,
    String? name,
    String? price,
    String? status,
    int? qty,
  }) =>
      Product(
        description: description ?? this.description,
        id: id ?? this.id,
        image: image ?? this.image,
        isFavourite: isFavourite ?? this.isFavourite,
        name: name ?? this.name,
        price: price ?? this.price,
        status: status ?? this.status,
        qty: qty ?? this.qty,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"],
        id: json["id"],
        image: json["image"],
        isFavourite: json["isFavourite"],
        name: json["name"],
        price: json["price"],
        status: json["status"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "image": image,
        "isFavourite": isFavourite,
        "name": name,
        "price": price,
        "status": status,
        "qty": qty,
      };
}
