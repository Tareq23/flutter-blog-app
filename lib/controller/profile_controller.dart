
import 'dart:convert';
import 'dart:io';

import 'package:blog_app/Services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/profile_model.dart';

class ProfileController extends GetxController
{
  var kajiList = <ProfileModel>[].obs;
  var profile = ProfileModel().obs;
  var isLoading = true.obs;
  var selectImagePath = ''.obs;
  var isFileImage = false.obs;
  @override
  void onInit()
  {
    fetchProfile();
    super.onInit();
  }

  void getImage(ImageSource imageSource) async
  {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      selectImagePath.value = pickedFile.path;
      profile.value.image = selectImagePath.value;
      isFileImage.value = true;
    }
    else{
      if(selectImagePath.value == null){
        showErrorSnackbar("No select Image");
      }
    }
  }
  Future<void> fetchProfile()async {
   if(isLoading.value){
     var result = await AppService.fetchUserProfile();

     if(result.image != null){
       var stringImage = result.image.toString().split('http');
       if(stringImage.length>2){
         selectImagePath.value = '';
       }
       else{
         selectImagePath.value = result.image.toString();
       }
       //print(stringImage.length);
     }
     //selectImagePath.value = result.image == null ? '' : result.image.toString();

     profile.value = result;
   }
   isLoading.value = false;
  }

  Future<void> updateProfile() async {
    var bytes;
    if(isFileImage.value){
      bytes = File(selectImagePath.value).readAsBytesSync();
    }
    Map<String, dynamic> user = {
      "name" : profile.value.name.toString(),
      "email" : profile.value.email.toString(),
      "about" : profile.value.about.toString(),
      "address" : profile.value.address.toString(),
      "phone" : profile.value.phone.toString(),
      "isFileImage" : isFileImage.value,
      "image" : isFileImage.value ? "data:image/png:base64, "+base64Encode(bytes) : "",
    };

    var result = await AppService.updateUserProfile(user);
    // print(result);
    if(result.id != null) {
        profile.value = result;
    }
    // print(result.name.toString());
  }


  Future<void> fetchKajiList() async {
    Map filter = {
      "name" : "",
      "division_id" : "",
      "district_id" : "",
      "sub_district_id" : "",
      "address" : "",
    };
    var result = await AppService.fetchKajiProfileList(filter);
    kajiList.addAll(result);
  }

  void showErrorSnackbar(String message)
  {
    Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffa02612),
        colorText: Colors.white
    );
  }

  void showSuccessSnackbar(String message)
  {
    Get.snackbar(
        "Success",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xff003402),
        colorText: Colors.white
    );
  }

}