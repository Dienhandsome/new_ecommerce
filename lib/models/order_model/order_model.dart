import 'dart:convert';

import 'package:final_ecommerce/models/product_models/product_model.dart';


class OrderModel {
  String orderId;
  String payment;
  List<ProductModel> products;
  String status;
  var totalPrice;

  OrderModel({
    required this.orderId,
    required this.products,
    required this.payment,
    required this.status,
    required this.totalPrice,
  });

  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   List<dynamic> productMap = json["products"];
  //   return OrderModel(
  
  //     orderId: json["orderId"] ,
  //     products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
  //     totalPrice: json["totalPrice"] ?? 0,
  //     status: json["status"],
  //     payment: json["payment"]
  //   );
  // }
 
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // // Kiểm tra xem "json" có là null không
    // if (json == null) {
    //   throw ArgumentError("Cannot parse null JSON data");
    // }

    // Kiểm tra xem "products" có là null không
    final List<dynamic>? productMap = json["products"];
    final List<ProductModel> productList = productMap != null
        ? productMap.map((e) => ProductModel.fromJson(e)).toList()
        : [];

    return OrderModel(
      orderId: json["orderId"] ?? "", // Đảm bảo orderId không null
      products: productList,
      totalPrice: json["totalPrice"] ,
      status: json["status"] ?? "", // Đảm bảo status không null
      payment: json["payment"] ?? "", // Đảm bảo payment không null
    );
  }
}


