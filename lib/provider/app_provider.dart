//import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

 // chuyển qua main dòng 23 để thêm các chức năng thêm,...,...
 //trang quản lí trạng thái trong flutter
class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];
  UserModel? _userModel; 

  //UserModel get getUserInformation =>  _userModel!; 
  UserModel get getUserInformation =>  _userModel ?? UserModel(id: '', name: '', image: '', email: '');
// ! giá trị không bao giờ null

  
  void removeCartProduct(ProductModel productModel){
    _cartProductList.remove(productModel);
    notifyListeners(); // trông giỏ hàng thêm hoặc xóa spham bạn gọi "notifyListeners();"
  } // tiếp theo nó sẽ thông báo dữ liệu thay đổi. Sau đó các widget liên kết với "ChangeNotifier" cập nhật lại
  //class AppProvider with ChangeNotifier
  List<ProductModel> get getCartProductList => _cartProductList;

  /// Made Favorite ///
  final List<ProductModel> _favoriteProductList = [];

  void addFavoriteCartProduct(ProductModel productModel){
    _favoriteProductList.add(productModel); // add favorite list
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel){
    _favoriteProductList.remove(productModel); // remove favorite list
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductList;
   
  //user info
  void getUserInforFirebase() async {
      _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
      notifyListeners();
  }
  

  Future<void> updateUserInfoFirebase(BuildContext context, userModel, File? file) async {
  
    if (file==null) {
       showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
      .collection("users")
      .doc(_userModel!.id)
      .set(_userModel!.toJson());
   
       Navigator.of(context, rootNavigator: true).pop();
       Navigator.of(context).pop();
    }else{
 showLoaderDialog(context);

      String imageUrl = await
      FirebaseStorageHelper
      .instance.uploadUserImage(file);  
      _userModel =  userModel.copyWith(image:  imageUrl);
       await FirebaseFirestore.instance
      .collection("users")
      .doc(_userModel!.id)
      .set(_userModel!.toJson());

      Navigator.of(context, rootNavigator: true).pop();
        }
         showMessage("Seccuessfully update profile ");
       notifyListeners();
  }

  // Total//
double totalPrice() {
  double totalPrice = 0.0;
  for (var element in _cartProductList) {
   
      totalPrice += element.price * element.qty!;
    
  }
  return totalPrice;
}

double totalPriceBuyProductList() {
  double totalPrice = 0.0;
  for (var element in _buyProductList) {
   
      totalPrice += element.price * element.qty!;
    
  }
  return totalPrice;
}
 

void updateQty(ProductModel productModel, int qty){
  int index =  _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
}
void addCartProduct(ProductModel productModel){
    _cartProductList.add(productModel);
    notifyListeners();
  }


//buy product//

void addBuyProduct(ProductModel model){
   _buyProductList.add(model);
   notifyListeners();
}
void addBuyProductCartList(){
  print( "Cart  " + _cartProductList.length.toString());
  print("Buy  " +  _buyProductList.length.toString());

   _buyProductList.addAll(_cartProductList);
    //thêm tất cả các phần tử từ danh sách _cartProductList vào danh sách _buyProductList
    print("Buy  " +  _buyProductList.length.toString());
   notifyListeners(); // thông báo về trạng thái đã được thái đổi
}
void clearCart(){
   _buyProductList.clear(); //xóa phần tử trong danh sách 
   notifyListeners(); // thông báo về trạng thái đã được thái đổi
}
void clearBuyProduct(){
   _buyProductList.clear(); //xóa sản phẩm mua
   notifyListeners(); // thông báo về trạng thái đã được thái đổi
}
List<ProductModel> get getBuyProductList => _buyProductList;
}