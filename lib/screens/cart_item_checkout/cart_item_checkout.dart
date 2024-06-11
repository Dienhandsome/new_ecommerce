import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:final_ecommerce/screens/stripe_helper/stripe_helper.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({super.key});

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 2;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "CheckOut",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 35.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.5)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 30.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.5)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2, // để chọn tick vào thanh toans onl hay cash
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                 appProvider.addBuyProductCartList();
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          context,
                          "Cash on delivery");
                  //được gọi để tải lên danh sách sản phẩm đã mua lên cơ sở dữ liệu Firebase.
                  appProvider.clearBuyProduct();

                  if (value) {
                    Future.delayed(Duration(seconds: 2), () {
                      // deplay thời gian chờ
                      Routes.instance
                          .push(widget: CustomBottomBar(), context: context);
                    });
                  }
                } else {
                  print("helo");
                  int value = double.parse(appProvider.totalPriceBuyProductList().toString()).round().toInt();
                  String totalPrice = (value * 100).toString();
                 // double totalPrice = appProvider.totalPrice() * 100;
                 print(totalPrice);
                   await StripeHelper.instance
                      .makePayment(totalPrice.toString(), context);
                  
                  }

                // appProvider.addBuyProductCartList();
                // bool value = await  FirebaseFirestoreHelper.instance
                // .uploadOrderedProductFirebase(  appProvider.getBuyProductList, context, groupValue == 1? "Cash on delivery":"Paid");
                // //được gọi để tải lên danh sách sản phẩm đã mua lên cơ sở dữ liệu Firebase.
                //   appProvider.clearBuyProduct();

                //    if (value) {
                //      Future.delayed(Duration(seconds: 2),(){ // deplay thời gian chờ
                // Routes.instance.push(widget: CustomBottomBar(), context: context);
                //      });
                //    }
              },
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
