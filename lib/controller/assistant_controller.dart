

import 'package:blog_app/Model/assistant_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../Services/color.dart';

class AssistantController extends GetxController
{

  var assistantList = <AssistantModel>[].obs;

  var isLoading = true.obs;
  var isAddAssistant = true.obs;
  var isRemoveAssistant = true.obs;

  @override
  void onInit() {

    super.onInit();
    fetchAssistant();
  }

  void fetchAssistant() async
  {
    if(isLoading.value){

      var result = await AppService.fetchAssistant();

      assistantList.assignAll(result);
      // print("assistent list length : -> ${assistantList.length}");
      isLoading.value = false;
    }
  }

  Future<bool> addAssistant(Map assistant) async {
    if(isAddAssistant.value){
      isAddAssistant.value = false;
      var result = await AppService.addAssistant(assistant);
      isLoading.value = result;
      if(result){
        Get.snackbar("Wow :)", "Successfully added your assistant");
      }
      isAddAssistant.value = true;
      return result;
    }
    return false;
  }
  void deleteAssistant(int id)async
  {
    if(isRemoveAssistant.value){
      isRemoveAssistant.value=false;
      var result = await AppService.deleteAssistant(id);
      isRemoveAssistant.value = true;
      if(result){
        Get.snackbar("Success", "Successfully removed assistant",backgroundColor: Color(
            0xe2c21f75));
      }
      else{
        Get.snackbar("Error","Something went to wrong!!",backgroundColor: ConstValue.focusColor);
      }
    }
  }


}