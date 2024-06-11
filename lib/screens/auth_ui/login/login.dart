// ignore_for_file: use_build_context_synchronously

import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:final_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isShowPassword = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopTitles(
                subtitle: "Welcome Back To Ecommerce App ", title: "Login"),

            const SizedBox(height: 12.0),

            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "E-mail",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 12.0),

            TextFormField(
              controller: passwordController,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.visibility, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            PrimaryButton(
              title: "Login",
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showMessage("Email or Password is Empty");
                } else {
                  bool isValidated = loginVaildation(
                      emailController.text, passwordController.text);
                  if (isValidated) {
                    bool isLoggedin = await FirebaseAuthHelper.instance
                        .login(emailController.text, passwordController.text, context);
                    if (isLoggedin) {
                      Routes.instance.push(
                          widget: const CustomBottomBar(), context: context);
                    } else {
                      showMessage("Login failed");
                    }
                 }
                }
              },
              width: 45, decoration:  BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.black, width: 1.0),
  ),
            ),

            SizedBox(height: 12.0),

            Center(child: Text("Don't have an account?")),

            SizedBox(height: 12.0),

            CupertinoButton(
              onPressed: () {
                Routes.instance.push(widget: SignUp(), context: context);
              },
              child: Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
