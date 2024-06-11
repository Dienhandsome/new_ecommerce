import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/order_model/order_model.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Order",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            List<OrderModel> orders = snapshot.data!;

            if (orders.isEmpty) {
              return const Center(
                child: Text("No Order Found"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(13.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = orders[index];
                print(orderModel.orderId + orderModel.payment + orderModel.status);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 140,
                            width: 130,
                            color: Colors.blue.withOpacity(0.5),
                            child: orderModel.products.isNotEmpty
                                ? Image.network(
                                    orderModel.products[0].image, 
                                  )
                                : Placeholder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: 190,
                            height: 110,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (orderModel.products.isNotEmpty)
                                    Text(
                                      orderModel.products[0].name, // Sửa lỗi: thêm ?? ''
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    "Total Price: \$${orderModel.totalPrice.toString()}",
                                  ),
                                  Text(
                                    "Order status: ${orderModel.status.toString()}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? orderModel.products.map((singleProduct) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.blue.withOpacity(0.5),
                                    child: singleProduct.image.isNotEmpty
                                        ? Image.network(
                                            singleProduct.image ?? '', // Sửa lỗi: thêm ?? ''
                                           
                                          )
                                        : Placeholder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: 190,
                                    height: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (orderModel.products.isNotEmpty)
                                            Text(
                                              singleProduct.name ?? '', // Sửa lỗi: thêm ?? ''
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          if (orderModel.products.isNotEmpty &&
                                              orderModel.products.length > 0 &&
                                              singleProduct.qty != null) // Kiểm tra nếu qty có giá trị
                                            Text(
                                              "Quality : ${singleProduct.qty.toString()}",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          Text(
                                            "Price: \$${singleProduct.price.toString()}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()
                        : [],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
