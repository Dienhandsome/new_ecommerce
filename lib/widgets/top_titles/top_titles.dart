import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title;
  final String subtitle;
  const TopTitles({super.key, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
              height: kToolbarHeight +12,
            ),
            if(title =="Login" || title == "Create Account")
               GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back)),
                SizedBox(
                  height:12 ,
                ),
            Text(
             title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 12,
            ),
            Text(
             subtitle,
            style: TextStyle(
              fontSize: 20.0,
              
            ),
            ),
      ],
    );
  }
}