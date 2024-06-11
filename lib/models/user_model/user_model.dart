import 'dart:convert';

UserModel categoriesModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String categoriesModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? name;
  String? image;
  String? email;

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email, String? phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // id: json["id"] != null ? json["id"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
      // name: json["name"] != null ? json["name"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
      // image: json["image"] != null ? json["image"] as String : "", // Kiểm tra và gán giá trị mặc định nếu là null
      // email: json["email"] != null ? json["email"] as String : "",
      id: json["id"] ?? "" ,
      name: json["name"] ,
      image: json["image"] ,
      email: json["email"] ,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "email": email,
      };

      UserModel copyWith({
  String? name,
  String ?image,
}) =>
    UserModel(
       id: id,
        name: name?? this.name,
        email: email,
        image: image,
       
    );


}


