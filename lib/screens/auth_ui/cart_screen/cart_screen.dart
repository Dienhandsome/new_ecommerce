//import 'package:final_ecommerce/screens/auth_ui/cart_screen/widgets/single_cart_item.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/screens/auth_ui/cart_screen/widgets/single_cart_item.dart';
import 'package:final_ecommerce/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:final_ecommerce/screens/check_out/check_out.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';

// phải làm riêng single_cart_item ra nếu để chung thì các botttom sẽ
// không xử lí được chức năng thêm hoặc giảm sản phẩm vì để chung sẽ
// hiểu ràng là 1 bottom khi nhấn một thêm hoặc giảm sản phẩm thì toàn
// bộ như nhau.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar:  SizedBox(
        height: 145.0,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),  
              const SizedBox(height: 0.4,),
              PrimaryButton(
                title: "CheckOut",
                onPressed: () {
                appProvider.clearBuyProduct();
                appProvider.addBuyProductCartList();
                appProvider.clearCart();
                 Routes.instance.push(widget: const CartItemCheckout(), context: context);
                },
                width: 150, 
                decoration:  BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.black, width: 1.0),
  ),
              ),
             
            ],
          ),
        ),
      ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Cart Screen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: appProvider.getCartProductList.length,
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (ctx, index) {
              final singleProduct = appProvider.getCartProductList[index];
              return SingleCartItem(
                // Đoạn này danh từ danh sách sản phẩm trong giỏ hàng sau đó
                singleProduct: singleProduct // co sanpham roi goi den thang getCartIndex chi
                  //và sau đó truyền vào một widget đó là SingleCart (// wiget độc lập (SingleCartItem))
              );
            }));
  }
}
