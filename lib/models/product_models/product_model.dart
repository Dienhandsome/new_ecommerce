
import 'dart:convert';
import 'dart:ffi';
//Json dùng để truyền dữ liệu của hệ thống
ProductModel productModelFromJson(String str) 
   => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
   json.encode(data.toJson());

class ProductModel {
  String image;
  String id;
  String name;
  var price; // em ddooir double nos co looi null String
  String description;

  bool isFavourite;
  int? qty;

  double? averageRating;
  //double? rating;


  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    
    required this.description,
    required this.isFavourite,
    this.qty,
    //required this.rating,
    this.averageRating = 0.0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ,
        name: json["name"] ,
        description:json["description"] ?? "" ,
        image: json["image"] ?? "", //vẫn là một chuỗi rỗng thay vì null.
        isFavourite:false ,
        //price: json["price"],
        price: double.parse(json["price"].toString()),
        qty: json["qty"],
        //rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "qty":qty,
        //"rating":rating,
      };
  
  ProductModel copyWith({
  int? qty,
}) =>
    ProductModel(
        id: id,
        name: name,
        description:description ,
        image: image,
        isFavourite:false ,
        price: price,
        //rating: rating,
        qty:qty??this.qty,
    );


}

