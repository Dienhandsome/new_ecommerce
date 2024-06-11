
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showMessage(String message){
  Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
    );
}


showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(content: Builder(builder: (context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text('Loading...'),
          )
        ],
      ),
    );
  }));
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

bool loginVaildation(String email,String password ){
   if(email.isEmpty && password.isEmpty){
    showMessage("Both Fields are empty");
     return false; 
  }
  else if(email.isEmpty){
    showMessage("Email is Empty");
     return false;
  }
  else if(password.isEmpty){
    showMessage("Password is Empty");
    return false;
  }else{
    return true;
  }
}

bool signUpVaildation(String email,String password, String name, String phone){
   if(email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty){
    showMessage("Both Fields are empty");
     return false; 
  }else if(name.isEmpty){
    showMessage("Name is Empty");
     return false;
  }
  else if(email.isEmpty){
    showMessage("Email is Empty");
     return false;
  }
  else if(phone.isEmpty){
    showMessage("Phone is Empty");
    return false;
  }
  else if(email.isEmpty){
    showMessage("Email is Empty");
     return false;
  }
  else if(password.isEmpty){
    showMessage("Pasword is Empty");
    return false;
  } else{
    return true;
  }
}