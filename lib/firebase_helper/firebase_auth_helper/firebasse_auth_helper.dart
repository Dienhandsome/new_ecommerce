

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/models/user_model/user_model.dart';
import 'package:final_ecommerce/screens/change_password/change_password.dart';
//import 'package:final_ecommerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthHelper {
 static FirebaseAuthHelper instance =  FirebaseAuthHelper();
 final FirebaseAuth _auth=FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

 Stream<User?> get getAuthChange=>_auth.authStateChanges();


 Future<bool> login(String email, String password, BuildContext context) async{
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Routes.instance.pushAndRemoveUntil(widget: Home(), context: context);
      Navigator.of(context).pop();
      return true;
    }on FirebaseAuthException catch(error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
 }

  Future<bool> signUp(
  String name, String email, String password, BuildContext context) async {
  try {
    showLoaderDialog(context);
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel userModel = UserModel(
      id: userCredential.user!.uid,
      name: name,
      email: email,
      image: null,
      //image: null,
    );


_firestore.collection("users").doc(userModel.id).set(userModel.toJson());

// as Map<String, dynamic>);
    Navigator.of(context).pop(); // Ẩn dialog loading
   // Routes.instance.pushAndRemoveUntil(widget: Home(), context: context); // Điều hướng đến màn hình Home và loại bỏ tất cả các màn hình khác
    return true;
  } on FirebaseAuthException catch (error) {
    Navigator.of(context).pop(); // Ẩn dialog loading
    showMessage(error.code.toString()); // Hiển thị thông báo lỗi
    return false;
  }
}
Future<void> signOut() async {
  await _auth.signOut(); // hàm đăng xuất người dùng
}

 // void getUserInformation() {}
Future<bool> ChangePassword(
   String password, BuildContext context) async {
  try {
    showLoaderDialog(context);
    _auth.currentUser!.updatePassword(password);






    
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     UserModel userModel = UserModel(
//       id: userCredential.user!.uid,
//       name: name,
//       email: email,
//       image: null,
//       //image: null,
//     );

// _firestore.collection("users").doc(userModel.id).set(userModel.toJson());

    Navigator.of(context, rootNavigator: true).pop();
    showMessage("Password changed "); 
     Navigator.of(context).pop(); // Ẩn dialog loading
   // Routes.instance.pushAndRemoveUntil(widget: Home(), context: context); // Điều hướng đến màn hình Home và loại bỏ tất cả các màn hình khác
    return true;
  } on FirebaseAuthException catch (error) {
    Navigator.of(context).pop(); // Ẩn dialog loading
    showMessage(error.code.toString()); // Hiển thị thông báo lỗi
    return false;
  }
}

// google
 Future <bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
 
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    
      try {
        // ignore: unused_local_variable
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final userId = _auth.currentUser!.uid;
        final userDoc =
            await _firebaseFirestore.collection("users").doc(userId).get();
        if (userDoc.exists) {
          // Người dùng đã tồn tại
          // ignore: avoid_print
          print("Người dùng đã tồn tại.");
        } else {
          // Người dùng chưa tồn tại
          UserModel userModel = UserModel(
              id: _auth.currentUser!.uid,
              name: _auth.currentUser!.displayName,
              email: _auth.currentUser!.email,
              phone: _auth.currentUser!.phoneNumber != "null"
                  ? "null"
                  : _auth.currentUser!.phoneNumber,
              
              image: _auth.currentUser!.photoURL);
          _firebaseFirestore
              .collection("users")
              .doc(userModel.id)
              .set(userModel.toJson());
        }
        return true;
      } catch (e) {
        // Xử lý lỗi
        // ignore: avoid_print
        print("Lỗi đăng nhập bằng Google: $e");
        return false;
      }
    } else {
      return false;
    }
  } 

}

