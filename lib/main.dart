import 'package:final_ecommerce/constants/theme.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/firebase_options/firebase_option.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/auth_ui/welcome/welcome.dart';
import 'package:final_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
//import 'package:final_ecommerce/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//thu nghiem 2// đúng
Future <void> main() async {
 Stripe.publishableKey = 
  "pk_test_51PIZ4eRwJpc3iA5fJnDJz7i3nvRtRoY0TPJDPLPDE1U94B4pKHzVPON7ZjuehlaIGuLEKeMBOSG3P676zZMsy7cE00ZlWZsooJ";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TĐ-Tech',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) { 
            return const CustomBottomBar();
          }
          return const Welcome();
        })
      ),
    );
  }
}
