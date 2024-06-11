//import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
//import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/auth_ui/cart_screen/cart_screen.dart';
import 'package:final_ecommerce/screens/check_out/check_out.dart';
import 'package:final_ecommerce/screens/favorite_screen/favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

// Trang làm chi tiết các mặt hàng chuyển qua "homme.dart"
class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1; // gán giá trị mặc định lần đầu =1 trong details

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
                      //listen: false: Đây là một tham số tùy chọn, mặc định là true. 
    return Scaffold(
    
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: const CartScreen(), context: context);
            },
             icon: const Icon(Icons.shopping_cart),
            //tạo ra Icon shopping cart chuyển qua theme để thiết kế màu ...
          ),
        ],
          toolbarHeight: 60, // Đặt chiều cao của thanh AppBar
      ),
       body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: MediaQuery.of(context).size.height, // Đặt chiều cao cho Container là chiều cao của màn hình
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 600,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite = !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                         appProvider.addFavoriteCartProduct(widget.singleProduct);
                      }else{
                         appProvider.removeFavoriteProduct(widget.singleProduct);
                      }
                     
                    },
                    icon: Icon(appProvider.getFavoriteProductList.contains(widget.singleProduct)
                    ? Icons.favorite : Icons.favorite_border
                    ),
                  ),
                ],
              ),
              Text(widget.singleProduct.description),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.remove),// giảm số lượng items
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.add), // thêm số lượng items
                    ),
                  )
                ],
              ),
              const SizedBox(height: 17.0,), 
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    // HIỆU ỨNG VIỀN
                    onPressed: () {
                      ProductModel productModel = widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel); // đoạn này được định nghĩa ở ProductModel sau đó tạo bản sau singleProduct 
                      showMessage("Added to Cart"); // và cập nhật lại số lượng "qty" "Added to Cart"
                    },

                    child: const Text("ADD TO CART"),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                         ProductModel productModel = widget.singleProduct.copyWith(qty: qty);
                          Routes.instance.push(widget: CheckOut(singleProduct :productModel
                          ), context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("BUY"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}