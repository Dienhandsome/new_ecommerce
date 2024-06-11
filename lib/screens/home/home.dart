import 'dart:ffi';

import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/category_model/category_model.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/screens/auth_ui/category_view/category_view.dart';
import 'package:final_ecommerce/screens/chatbot_screen/chat_screen.dart';
import 'package:final_ecommerce/screens/product_details/product_details.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoanding = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider
        .getUserInforFirebase(); // có tác động người dùng gọi lấy từ firebase
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoanding = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoanding = false;
      });
    }
  }

  // Search //
  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    // Tìm kiếm các sản phẩm thỏa mãn điều kiện
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList(); // Chỗ contains là tìm kiếm other trong tất cả các từ
    // In ra số lượng sản phẩm tìm thấy (không cần thiết)
    print(searchList.length);
    setState(() {
      // Gọi setState để cập nhật giao diện khi đã tìm thấy sản phẩm
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoanding
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 200,
                            top: 6), // Giảm giá trị top xuống 10 đơn vị
                        child: TopTitles(subtitle: "", title: "TĐ Ecommerce"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: TextFormField(
                          
                          controller: search,
                          onChanged: (String value) {
                            searchProducts(value);
                          },
                          decoration: const InputDecoration(
                            hintText: "Search....",
                            prefixIcon: Icon(Icons.search),
                             
                           // contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 18), // chỉnh kích cỡ form
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  
                  Row(
                    children: [
                    const Padding(
                      padding: EdgeInsets.only(left:22 ,right: 180),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        color: Colors.black,
                        iconSize: 32.0,
                        icon: const Icon(
                          Icons.support_agent_outlined,
                        ),
                        onPressed: () {
                          setState(() {});
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ChatScreen();
                              },
                            ),
                            (_) => false,
                          );
                        },
                      ),
                    ),
                  ]),

                  const SizedBox(height: 12.0),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Đặt hướng cuộn là ngang
                          child: Row(
                            children: categoriesList
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0,
                                          left:
                                              4.0), // Điều chỉnh khoảng cách giữa các phần tử
                                      child: CupertinoButton(
                                        // là thiết kế giao diện gần như IOS
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Routes.instance.push(
                                             widget: CategoryView(
                                                 categoryModel: e),
                                              context: context);
                                        },
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: CategoryView(
                                                    categoryModel: e),
                                                context: context);
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 13.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), //độ bo góc của card là thành phần nằm dưới để tấm ảnh vô khuôn
                                            ),
                                            child: ClipRRect(
                                              // Áp dụng độ bo góc cho ảnh
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(e.image
                                                    // fit: BoxFit.cover,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 1.0,
                      left: 2.0,
                    ),
                    child: SizedBox(
                      height: 12.0,
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(right: 240.0),
                      child: Text(
                        "Best Product",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(height: 14.0),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("No Product Found"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              // chỉnh search
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 8.0, right: 8.0),
                              child: GridView.builder(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        1), // bottom "phía dưới không chạm vào nav-bar"

                                // kéo dưới phần best pro gần nó hơn
                                shrinkWrap: true,

                                physics:
                                    const NeverScrollableScrollPhysics(), // Ngăn cuộn tự động của GridView
                                itemCount: searchList.isNotEmpty
                                    ? searchList.length
                                    : productModelList.length, // chỉnh search
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing:
                                      20, // chỉnh khoảng cách giữa các productModel
                                  crossAxisSpacing:
                                      17, // chỉnh khoảng cách giữa các productModel
                                  childAspectRatio:
                                      0.7, //chiều rộng của mỗi mục con sẽ là 80% chiều cao của nó
                                  crossAxisCount:
                                      2, // chỉnh product 2 sản phẩm nằm trên dòng
                                ),
                                itemBuilder: (ctx, index) {
                                  // Lấy ra đối tượng ProductModel từ danh sách bestProducts
                                  ProductModel singleProduct = searchList
                                          .isNotEmpty
                                      ? searchList[index]
                                      : productModelList[
                                          index]; //searchList[index]; // chỉnh search
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 70, 79, 86)
                                          .withOpacity(
                                              0.5), //chỉnh độ đạm nhạc của màu nền
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Độ bo góc 10.0
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Độ bo góc 10.0 cho hình ảnh
                                          child: Image.network(
                                            singleProduct.image,
                                            height: 70,
                                            width:
                                                120, // kích thước ảnh product
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Price: \$${singleProduct.price}"),
                                        //Price: $ hiện thị gái trị sản phẩm
                                        // ${singleProduct.price}: Đây là một biểu thức nội suy (interpolation) của Dart
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              // Hành động khi nhấn nút mua
                                             Routes.instance.push(
                                                 widget: ProductDetails(
                                                     singleProduct:
                                                         singleProduct),
                                                  context: context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text("Best Products is empty"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, left: 8.0, right: 8.0),
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            70), // bottom "phía dưới không chạm vào nav-bar"

                                    // kéo dưới phần best pro gần nó hơn
                                    shrinkWrap: true,

                                    physics:
                                        const NeverScrollableScrollPhysics(), // Ngăn cuộn tự động của GridView
                                    itemCount: productModelList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing:
                                          20, // chỉnh khoảng cách giữa các productModel
                                      crossAxisSpacing:
                                          17, // chỉnh khoảng cách giữa các productModel
                                      childAspectRatio:
                                          0.6, // Box : chiều rộng của mỗi mục con sẽ là 80% chiều cao của nó
                                      crossAxisCount:
                                          2, // chỉnh product 2 sản phẩm nằm trên dòng
                                    ),
                                    itemBuilder: (ctx, index) {
                                      // Lấy ra đối tượng ProductModel từ danh sách bestProducts
                                      ProductModel singleProduct =
                                          productModelList[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 127, 152,
                                                  184) // đổi màu container bestproduct
                                              .withOpacity(
                                                  0.5), //chỉnh độ đạm nhạc của màu nền
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Độ bo góc 10.0
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20)),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Độ bo góc 10.0 cho hình ảnh
                                              child: Image.network(
                                                singleProduct.image,
                                                height: 70,
                                                width:
                                                    120, // kích thước ảnh product
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Text(
                                              singleProduct.name,
                                              style: const TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                                "Price: \$${singleProduct.price}"),
                                            //Price: $ hiện thị gái trị sản phẩm
                                            // ${singleProduct.price}: Đây là một biểu thức nội suy (interpolation) của Dart
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 24,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                                // Thực hiện các hành động khi người dùng cập nhật đánh giá
                                              },
                                            ),

                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: 140,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  //Hành động khi nhấn nút mua
                                                  Routes.instance.push(
                                                      widget: ProductDetails(
                                                          singleProduct:
                                                              singleProduct),
                                                      context: context);
                                                },
                                                child: const Text(
                                                  "Buy",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255,
                                                        26,
                                                        26,
                                                        26), // Đặt màu chữ thành xám
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                  const SizedBox(
                    height: 12.0,
                  ),
//            Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
// Padding(
//                     padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
//                     child: RatingBar.builder(
//                       initialRating: 3,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemSize: 20,
//                       itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                       onRatingUpdate: (rating) {
//                         print(rating);
//                         // Thực hiện các hành động khi người dùng cập nhật đánh giá
//                       },
//                     ),
//                   ),
//             ],
//           )
                ],
              ),
            ),
    );
  }
}
// List<String> categoriesList = [
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRWlvZecWiUleGf5gmQGybdb5uJH39rl56mQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuATYwGWWlJsLlrkGcr9t_1exozfu_RDKYj6HVJbzNw2DW0Gb0tMk-sttAk2tMUZaDUSE&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaKgorUKxroGEo-lMcLiJj2gT76k5uINKJjQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTFw21efqheE9RtPvcmyIo3Gd6MXuKG8wRbA&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqAqmqMVYDQsZQzFuf3Kh6SRWzIB6wT7WOVw&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7156KJGgLP5_ph5fjotrL0de4PYfAS5AGFQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT05aiS9rQIGng4GTdba5QrTyD19ifmegJhJOhSry6eVPo_s9wcWfdtwRRScgv6rLyn810&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIFntj51xH5GZ2Vj4QhIDHfyK4HiqwZ8cwnQ&usqp=CAU"
// ];

// List<ProductModel> bestProducts = [
//   ProductModel(
//     image:
//         "https://vcdn.tikicdn.com/ts/tmp/e5/0b/da/886eb5f9849c728433540b87a9910a32.jpg",
//     id: "1",
//     name: "Ethernet Lan",
//     price: "20",
//     status: "pending",
//     description: "It's use quite ok. People should buy it?",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://tse4.mm.bing.net/th?id=OIP._ne0oEcicAdTs5qxGbREFAHaFZ&pid=Api&P=0&h=180",
//     id: "3",
//     name: "Iphone 13",
//     price: "200",
//     status: "pending",
//     description: "Iphone this 13 looking lady.",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://tse4.mm.bing.net/th?id=OIP.QX9o43DgoMsRcgRJn8XLAAHaC7&pid=Api&P=0&h=180",
//     id: "3",
//     name: "Keyboard",
//     price: "200",
//     status: "pending",
//     description: "Iphone this 13 looking lady.",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://vcdn.tikicdn.com/ts/tmp/e5/0b/da/886eb5f9849c728433540b87a9910a32.jpg",
//     id: "1",
//     name: "Ethernet Lan",
//     price: "20",
//     status: "pending",
//     description: "It's use quite ok. People should buy it?",
//     isFavouraite: false,
//   ),

// ];
