//  import 'dart:convert';
// import 'package:final_ecommerce/constants/routes.dart';
// import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
// import 'package:final_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripeHelper {
//   static StripeHelper instance = StripeHelper();
//   Map<String, dynamic>? paymentIntent;

//   Future<bool> makePayment(String amount) async {
//     try {
//       paymentIntent = await createPaymentIntent("10000", 'USD');

//       var gpay = const PaymentSheetGooglePay(
//         merchantCountryCode: "US",
//         currencyCode: "USD",
//         testEnv: true,
//       );

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           style: ThemeMode.light,
//           merchantDisplayName: 'fegno',
//           googlePay: gpay,
//         ),
//       );

//       await displayPaymentSheet();
//       return true;
//     } catch (err) {
//       print(err);
//       return false;
//     }
//   }

//   Future<void> displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentCustomerSheet().then((value) {
//         print("Payment Successfully");
//         // Thêm xử lý sau khi thanh toán thành công ở đây
//       });
//     } catch (e) {
//       print('Error displaying payment sheet: $e');
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               "Bearer sk_test_51PIZ4eRwJpc3iA5feQwQDGBXStlzZh9WGUMHpxVGYa9IixQ69k0j7e21v8el7RXqtDiiMnFtUPmABXbWsySdctMI00W2XqBgOC",
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }


// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      print(amount);
      paymentIntent = await createPaymentIntent(amount, 'USD');

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!
          ['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'fegno',
          googlePay: gpay)).then((value) => {});
      
      // Hiển thị Customer Sheet
     displayPaymentSheet(context);
    
    } catch (err) {
      
    }
  }

 displayPaymentSheet(BuildContext context) async {
  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        bool value = await FirebaseFirestoreHelper.instance
                        .uploadOrderedProductFirebase(
                            appProvider.getBuyProductList,
                            context,
                            "Paid");
                    //được gọi để tải lên danh sách sản phẩm đã mua lên cơ sở dữ liệu Firebase.
                    appProvider.clearBuyProduct();

                    if (value) {
                      Future.delayed(Duration(seconds: 2), () {
                        // deplay thời gian chờ
                        Routes.instance
                            .push(widget: CustomBottomBar(), context: context);
                      });
                    }
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              "Bearer sk_test_51PIZ4eRwJpc3iA5feQwQDGBXStlzZh9WGUMHpxVGYa9IixQ69k0j7e21v8el7RXqtDiiMnFtUPmABXbWsySdctMI00W2XqBgOC",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
