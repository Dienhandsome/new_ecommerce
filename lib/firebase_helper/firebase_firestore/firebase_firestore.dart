import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/models/category_model/category_model.dart';
import 'package:final_ecommerce/models/order_model/order_model.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/models/rating_model/rating_model.dart';
import 'package:final_ecommerce/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';


class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List< CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot
       = await _firebaseFirestore.collection("categories").get();
      
      List< CategoryModel> categoriesList = querySnapshot.docs.map(
        (e) =>  CategoryModel.fromJson(e.data())).toList();
      
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot
       = await _firebaseFirestore.collectionGroup("products").get();
      
      List< ProductModel> productModelList = querySnapshot.docs.map(
        (e) =>  ProductModel.fromJson(e.data())).toList();
      
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }



  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try { // hàm getcate... sử dụng để lấy danh sách sản phẩm từ một danh mục cụ thể trong cơ sở dữ liệu Firebase.
      QuerySnapshot<Map<String, dynamic>> querySnapshot
       = await _firebaseFirestore
       .collection("categories")
       .doc(id)
       .collection("products")
       .get();
      
      List<ProductModel> productModelList = querySnapshot.docs
      .map((e) =>  ProductModel.fromJson(e.data()))
      .toList();
      print(productModelList.length);
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

   Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot
       = await _firebaseFirestore
       .collection("users")
       .doc(FirebaseAuth.instance.currentUser!.uid) //chọn tài liệu/document có ID là UID của người dùng hiện tại đang đăng nhập vào ứng dụng.
       .get(); //thực hiện truy vấn để lấy dữ liệu từ tài liệu đó.
       
     return UserModel.fromJson(querySnapshot.data() ?? {});

  }  //! chỉ thị rằng dữ liệu sẽ không bao giờ null

  Future<bool> uploadOrderedProductFirebase( // em ch 
    List<ProductModel> list, BuildContext context, String payment) async {
  try {
    print("Buy  " +  list.length.toString());
    showLoaderDialog(context);
    var totalPrice = 0.0;
    for (var element in list) {
       totalPrice += element.price * element.qty!; // Xem xét xử lý khi qty null
    }

    DocumentReference documentReference = _firebaseFirestore
        .collection("userOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc();

    DocumentReference admin = _firebaseFirestore.collection("orders").doc(documentReference.id);
   String uid = FirebaseAuth.instance.currentUser!.uid;
    admin.set({
      "products": list.map((e) => e.toJson()),
      "status": "Pending",
      "totalPrice": totalPrice,
      "payment": payment,
      "orderId": admin.id,
    });
    documentReference.set({
      "products": list.map((e) => e.toJson()).toList(),
      "status": "Pending",
      "totalPrice": totalPrice,
      "payment": payment,
      "orderId": documentReference.id,
    });

    Navigator.of(context, rootNavigator: true).pop();
    showMessage("Ordered Successfully");
    return true;
  } catch (e) {
    showMessage(e.toString());
    Navigator.of(context, rootNavigator: true).pop();
    return false;
  }
}

  /// get order ///
  
  // Future<List<OrderModel>> getUserOrder () async {
  //  try {
 
  //    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore.collection("userOrders")
  //  .doc(FirebaseAuth.instance.currentUser!.uid)
  //  .collection("orders")
  //  .get();

  // List<OrderModel> orderModel =  querySnapshot.docs.
  //    map((element) => OrderModel.fromJson(element.data())).toList();
     
      
  //    return orderModel;
  //  } catch (e) {
  //    return [];
  //  }
  //}

  Future<List<OrderModel>> getUserOrder() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("userOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<OrderModel> orderModelList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();
          print(orderModelList.length); 
      return orderModelList;
    } else {
      return [];
    }
  } catch (e) {
    showMessage(e.toString());
    return [];
  }
}


Future<void> updateOrderReview(String orderId, String statusReview) async {
    // Nguời dùng hủy đơn hàng
    if (statusReview.contains("Review")) {
      await _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc(orderId)
          .update({
        "statusReview": statusReview,
      });

      await _firebaseFirestore.collection("orders").doc(orderId).update({
        "statusReview": statusReview,
      });
    }
  }




  Future<bool> isRatingOrder(String orderId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot_userRatingList =
        await _firebaseFirestore
            .collection("usersRatings")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("ordersRatigs")
            .doc(orderId)
            .collection("ratings")
            .get();
    List<RatingModel> ratingList = querySnapshot_userRatingList.docs
        .map((element) => RatingModel.fromJson(element.data()))
        .toList();

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("usersOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .get();

    List<OrderModel> orderList = querySnapshot.docs
        .map((element) => OrderModel.fromJson(element.data()))
        .toList();
    late OrderModel orderModel;
    if (orderList.isNotEmpty) {
      orderModel =
          orderList.firstWhere((element) => element.orderId == orderId);
      if (orderModel.products.length == ratingList.length) {
        return true;
      }
    }
    return false;
  }

  Future<bool> uploadRatingFirebase(
      String orderID, RatingModel rating, BuildContext context) async {
    try {
      showLoaderDialog(context);
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersRatings")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("ordersRatigs")
          .doc(orderID)
          .collection("ratings")
          .doc(rating.productId);

      documentReference.set({
        "productId": rating.productId,
        "userId": rating.userId,
        "rating": rating.rating,
        "content": rating.content
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Rating Successfully");

      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

void updateTokenFromFirebase() async{
 String? token = await FirebaseMessaging.instance.getToken();
 if(token != null){
    await _firebaseFirestore.collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .update({"notificationToken": token});
 }
}
}