import 'package:final_ecommerce/constants/asset_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Support",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8), // Điều chỉnh nếu cần
            Image.asset(
              AssetImages.instance.AboutUsImage, // Truy cập tài nguyên bằng tiện ích tùy chỉnh của bạn
              scale: 28.0, // Điều chỉnh scale nếu cần
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Căn văn bản sang trái
            children: [
              Image.asset(
                AssetImages.instance.AboutUsImage,
              ),
              const SizedBox(height: 34.0,),
              const Text(
                "Support" ,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                //textAlign: TextAlign.center, // Căn văn bản đều hai bên
              ),
              const SizedBox(height: 34.0,),
              const Text(
                "Hotline: 0862209606" ,
               // textAlign: TextAlign.center, // Căn văn bản đều hai bên
              ),
              const Text(
                "Gmail: dien@gmail.com" ,
              //  textAlign: TextAlign.center, // Căn văn bản đều hai bên
              ),
              SizedBox(height: 16), // Điều chỉnh nếu cần
              // Truy cập tài nguyên bằng tiện ích tùy chỉnh của bạn
            ],
          ),
        ),
      ),
    );
  }
}
