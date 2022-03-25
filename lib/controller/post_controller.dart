import 'dart:convert';

import 'package:blog_app/Model/post_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class PostController extends GetxController{


  var isLoading = true.obs;

  var allPostList = <PostModel>[].obs;
  var postDetails = PostModel().obs;
  var userPostList = <PostModel>[].obs;
  var updatePost = PostModel().obs;
  var selectImagePath = ''.obs;

  var createPost = PostModel().obs;

  @override
  void onInit() {
    fetchPosts();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void fetchPosts() async {
    try{
      isLoading(true);
      var allPosts = await AppService.fetchAllPost();
      allPostList.assignAll(allPosts);
    }
    finally{
      isLoading(false);
      fetchUserPosts();
    }
  }

  void fetchUserPosts() async {
    try{
      var userPosts = await AppService.fetchUserPost();
      userPostList.assignAll(userPosts);
    }
    finally{

    }
  }

  void postUpdate() async{
    Map map = {
      "headline" : updatePost.value.headline,
      "content" : updatePost.value.content
    };
    // print(map);
    isLoading = (await AppService.updatePost(map, updatePost.value.id as int)) as RxBool;
    if(isLoading.value){
      fetchUserPosts();
    }
  }

  void getImage(ImageSource imageSource) async
  {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      selectImagePath.value = pickedFile.path;
    }
    else{
     if(selectImagePath.value == null){
       showErrorSnackbar("No select Image");
     }
    }
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
        backgroundColor: const Color(0xffa02612),
        colorText: Colors.white
    );
  }


  void createNewPost() async
  {
    var bytes = File(selectImagePath.value).readAsBytesSync();
    try{
      Map<String,dynamic> postBody = {
        "headline" : createPost.value.headline,
        "content" : createPost.value.content,
        "status" : createPost.value.status,
        "job_id" : createPost.value.job_id,
        "image" : "data:image/png:base64, "+base64Encode(bytes),
      };
      var result = await AppService.createPost(postBody);
      if(result == "201" || result == "200"){
        showSuccessSnackbar("Post Create Successfully");
        Get.back();
      }
      else{
        showErrorSnackbar("Something's Wrong");
      }
    }
    catch(message){
      showErrorSnackbar(message.toString());
    }
    finally{

    }
  }

}