// To parse this JSON data, do
//
//     final productWithIdModel = productWithIdModelFromJson(jsonString);

import 'dart:convert';

ProductWithIdModel productWithIdModelFromJson(String str) =>
    ProductWithIdModel.fromJson(json.decode(str));

String productWithIdModelToJson(ProductWithIdModel data) =>
    json.encode(data.toJson());

class ProductWithIdModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductWithIdModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductWithIdModel.fromJson(Map<String, dynamic> json) =>
      ProductWithIdModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
