
import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  int id;
  String name;
  String specification;
  String price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  int? userId;
  String userUsername;

  ProductEntry({
    required this.id,
    required this.name,
    required this.specification,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.userId,
    required this.userUsername,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        specification: json["specification"] ?? "",
        price: json["price"],
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"],
        isFeatured: json["is_featured"],
        userId: json["user_id"],
        userUsername: json["user_username"] ?? "Unknown",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specification": specification,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "user_id": userId,
        "user_username": userUsername,
      };
}
