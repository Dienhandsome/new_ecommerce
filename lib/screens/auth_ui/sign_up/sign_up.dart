import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/contants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  bool isShowPassword = true;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // giúp xử lí màn hình không thay đổi kích thước và giao diện không hiện lên án màn
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                  subtitle: "Welcome Back To Ecommerce App ", title: "SignUp"),

              SizedBox(
                height: 12.0,
              ),

              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name", // cmt trong border
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),

              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "E-mail", // cmt trong border
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),

              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Phone", // cmt trong border
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ), // ô nhập login
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: password,
                obscureText:
                    isShowPassword, // bật chế độ bảo mật cho nhập mật khẩu
                decoration: InputDecoration(
                  hintText: "Password", // cmt trong border
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
                height: 24.0,
              ),
              PrimaryButton(
                title: "Create an account",
                onPressed: () async {
                  Routes.instance.push(widget: const SignUp(), context: context);
                  bool isVaildated = signUpVaildation(
                      email.text, password.text, name.text, phone.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const Home(), context: context);
              
                    }
                  }
                  
                  
                },
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Center(child: Text("I have already an account?")),
              const SizedBox(
                height: 12.0,
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
