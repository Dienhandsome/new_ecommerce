import 'package:final_ecommerce/provider/app_provider.dart';
//import 'package:final_ecommerce/screens/auth_ui/cart_screen/widgets/single_cart_item.dart';
import 'package:final_ecommerce/screens/favorite_screen/widgets/single_favorite_item.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreeen extends StatelessWidget {
  const FavoriteScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favorite Screen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: appProvider.getFavoriteProductList.length,
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (ctx, index) {
              return SingleFavoriteItem(
                 singleProduct: appProvider.getFavoriteProductList[index],
                  
              );
            }));
  }
}
