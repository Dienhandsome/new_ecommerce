import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/about_us/about_us.dart';
import 'package:final_ecommerce/screens/auth_ui/welcome/welcome.dart';
import 'package:final_ecommerce/screens/change_password/change_password.dart';
import 'package:final_ecommerce/screens/edit_profile/edit_proflie.dart';
import 'package:final_ecommerce/screens/favorite_screen/favorite_screen.dart';
import 'package:final_ecommerce/screens/order_screen/order_screen.dart';
import 'package:final_ecommerce/screens/support_screen/support_screen.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Account",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Column(
                children: [
                  appProvider.getUserInformation.image?.isEmpty ?? true
                      ? const Icon(
                          Icons.person_outlined,
                          size: 120,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(appProvider.getUserInformation.image!),
                          radius: 60,
                        ),
                  Text(
                    appProvider.getUserInformation?.name ?? "TĐTech",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    appProvider.getUserInformation?.email ?? "dien@gmail.com",
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 170,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: PrimaryButton(
                          title: "Edit My Profile",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                          },
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
                    },
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text("Your Order"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreeen()));
                    },
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text("Favorite"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
                    },
                    leading: const Icon(Icons.info_outline),
                    title: const Text("About"),
                  ),
                  ListTile(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
                    },
                    leading: const Icon(Icons.support_agent_outlined),
                    title: const Text("Support"),
                  ),
                  ListTile(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
                    },
                    leading: const Icon(Icons.support_agent_outlined),
                    title: const Text("Rating"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassword()));
                    },
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text("Change Password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Log out"),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text("version 1.2.0")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
