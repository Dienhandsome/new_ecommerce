
import 'dart:convert';

CategoryModel categoriesModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoryModel data) =>
    json.encode(data.toJson());

class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

 factory CategoryModel.fromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json["id"] != null ? json["id"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
    name: json["name"] != null ? json["name"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
    image: json["image"] != null ? json["image"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
  );
}
  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}