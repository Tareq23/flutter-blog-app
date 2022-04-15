

import 'package:blog_app/Model/message_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:get/get.dart';

class MessageController extends GetxController
{

  var msgList = <MessageModel>[].obs;
  var text = ''.obs;

  @override
  void onInit() {
    fetchMessages();
    super.onInit();
  }

  Future<void> fetchMessages() async
  {
    var _msgList = await AppService.fetchMessage();
    msgList.assignAll(_msgList);
    //print(_msgList);
  }
  Future<bool> sendMessage(int id) async
  {
    Map message;
    if(id == 0){
      message = {
        "body" : text.value.toString()
      };
    }
    else{
      message = {
        "body" : text.value.toString(),
        "parent_id" : id
      };
    }
    //print(message);
    try{
      return await AppService.sendMessage(message);
    }
    catch(e){
      // print(e);
    }
    return false;
  }
}