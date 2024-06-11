import 'package:final_ecommerce/constants/asset_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "About Us",
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
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn văn bản sang trái
          children: [
            Image.asset(
              AssetImages.instance.AboutUsImage,
            ),
            const SizedBox(height: 34.0,),
            const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 2024s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textAlign: TextAlign.justify, // Căn văn bản đều hai bên
            ),
            SizedBox(height: 16), // Điều chỉnh nếu cần
             // Truy cập tài nguyên bằng tiện ích tùy chỉnh của bạn
            
          ],
        ),
      ),
    );
  }
}
