import 'dart:io';

import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:final_ecommerce/models/user_model/user_model.dart';
import 'package:final_ecommerce/provider/app_provider.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
     void takePicture() async{
      XFile? value = await ImagePicker()
      .pickImage(source: ImageSource.gallery,imageQuality: 38,
      );
      if(value != null){
        setState(() {
          image = File(value.path);
        });
      }
     }
  
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        children: [
          image==null? CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child:  const CircleAvatar(
              radius: 60,
              child:
                 Icon(Icons.camera_alt),
              
              ),
            ):CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child:  CircleAvatar(
              backgroundImage:  FileImage(image!),
              radius: 60,
              
              
              ),
            ) ,
            const SizedBox(height: 12.0,),
           TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: appProvider.getUserInformation.name,
            ),
           ),
           const SizedBox(height: 12.0,),
           PrimaryButton(title: 
           "Update",
           onPressed: () async{
           UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
             appProvider.updateUserInfoFirebase(context, userModel, image);
             
             
           }, width: 45, decoration:  BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.black, width: 1.0),
  ),
           ),
        ],
        ),
    );
  }
}

