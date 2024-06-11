import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/models/user_model/user_model.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confrimpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Change Password",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            TextFormField(
              controller: newpassword,
              obscureText:
                  isShowPassword, // bật chế độ bảo mật cho nhập mật khẩu
              decoration: InputDecoration(
                hintText: "New Password", // cmt trong border
                prefixIcon: const Icon(
                  Icons.password_sharp,
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )), // tạo mắt trong password
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: confrimpassword,
              obscureText:
                  isShowPassword, // bật chế độ bảo mật cho nhập mật khẩu
              decoration: const InputDecoration(
                hintText: "Confrim Password", // cmt trong border
                prefixIcon: Icon(
                  Icons.password_sharp,
                ),
              
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            PrimaryButton(
              title: "Update",
              onPressed: () async {
                if (newpassword.text.isEmpty) {
                  showMessage("New Password is empty");
                } else if (confrimpassword.text.isEmpty) {
                  showMessage("Confrim Password is empty");
                } else  if (confrimpassword.text == newpassword.text) {
                    FirebaseAuthHelper.instance
                        .ChangePassword(newpassword.text, context);
                  } else {
                    showMessage("Confrim Password is not match");
                  }
              },
              width: 45, decoration:  BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.black, width: 1.0),
  ),
            ),
          ],
        ));
  }
}
