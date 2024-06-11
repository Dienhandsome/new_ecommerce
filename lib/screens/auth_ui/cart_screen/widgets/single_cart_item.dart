import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

//xử lí các chức năng trong cart nhưng chưa có push
// wiget độc lập (SingleCartItem)
// Widget độc lập (SingleCartItem) để xử lý các chức năng trong giỏ hàng
class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemStateState();
}

class _SingleCartItemStateState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.blue,
          width: 3.3,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.blue.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            widget.singleProduct.name,
                            style: const TextStyle(
                              
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                if (qty >= 1) {
                                  setState(() {
                                    qty--;
                                  });
                                   appProvider.updateQty(widget.singleProduct, qty);
                                }
                              },
                              padding: EdgeInsets.zero,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                               
                                setState(() {
                                  qty++;
                                });
                                 appProvider.updateQty(widget.singleProduct, qty);
                              },
                              padding: EdgeInsets.zero,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                       
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!appProvider.getFavoriteProductList
                                .contains(widget.singleProduct)) {
                              appProvider
                                  .addFavoriteCartProduct(widget.singleProduct);
                              showMessage("Added to List");
                            } else {
                              appProvider
                                  .removeFavoriteProduct(widget.singleProduct);
                              showMessage("Remove to List");
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                appProvider.getFavoriteProductList
                                        .contains(widget.singleProduct)
                                    ? "Remove to List"
                                    : "Add to List",
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 8, 137, 243),
                                ),
                              ),
                              const SizedBox(width: 3.0,),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  AppProvider appProvider = Provider.of(context, listen: false);
                                  appProvider.removeCartProduct(widget.singleProduct);
                                  showMessage("Removed from Cart");
                                },
                               
                                child: const CircleAvatar(
                                  maxRadius: 18,
                                  child: Icon(Icons.delete,
                                  color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                   
                    Text(
                      "\$${widget.singleProduct.price.toString()}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
