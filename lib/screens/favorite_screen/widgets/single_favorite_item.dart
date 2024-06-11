import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//xử lí các chức năng trong cart nhưng chưa có push
// wiget độc lập (SingleCartItem)
class SingleFavoriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavoriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavoriteItem> createState() => _SingleFavoriteItemStateState();
}

class _SingleFavoriteItemStateState extends State<SingleFavoriteItem> {
  @override
  Widget build(BuildContext context) {
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
                        Text(
                          widget.singleProduct.name,
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
                            appProvider.removeFavoriteProduct(widget.singleProduct);
                            showMessage("Remove to List");
                          },
                          child: const Text(
                            "Remove to List",
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 8, 137, 243),
                            ),
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
          )
        ],
      ),
    );
  }
}
