// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String description;
  String image;
  bool isFavourite;
  String name;
  double price;
  int? qty;

  Product({
    required this.id,
    required this.description,
    required this.image,
    required this.isFavourite,
    required this.name,
    required this.price,
    required this.qty,
  });

  Product copyWith({
    String? id,
    String? description,
    String? image,
    bool? isFavourite,
    String? name,
    double? price,
    int? qty,
  }) =>
      Product(
        id: id ?? this.id,
        description: description ?? this.description,
        image: image ?? this.image,
        isFavourite: isFavourite ?? this.isFavourite,
        name: name ?? this.name,
        price: price ?? this.price,
        qty: qty ?? this.qty,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        description: json["description"],
        image: json["image"],
        isFavourite: json["isFavourite"],
        name: json["name"],
        price: double.parse(json["price"].toString()),
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "image": image,
        "isFavourite": isFavourite,
        "name": name,
        "price": price,
        "qty": qty,
      };
}
