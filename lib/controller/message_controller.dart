

import 'package:blog_app/Model/message_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:blog_app/conversation/message_ui.dart';
import 'package:get/get.dart';

class MessageController extends GetxController
{

  var isLoadingAdminMessage = true.obs;
  var adminMessageList = <MessageModel>[].obs;


  var isLoadingMessage = true.obs;
  var msgList = <MessageModel>[].obs;
  var text = ''.obs;

  var isSendMessage = false.obs;
  var sentMessage = MessageModel(0, 0, "name", "messageText", "imgUrl", DateTime.now(), "createdAtAgo").obs;



  @override
  void onInit() {
    //fetchMessages();
    super.onInit();
  }


  void fetchAdminMessage() async {
    if(isLoadingAdminMessage.value){

      var result = await AppService.fetchAdminMessage({
        "skip" : 0,
        "take" : 20
      });

      adminMessageList.addAll(result);

      //print("Admin info size : ${result.length}");

      isLoadingAdminMessage.value = false;
    }
  }

  Future<void> fetchMessages() async
  {
    if(isLoadingMessage.value){
      var _msgList = await AppService.fetchMessage();
      msgList.assignAll(_msgList.reversed);
      isLoadingMessage.value = false;
      //fetchAdminMessage();
    }

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
      if(isSendMessage.value){
        var result =  await AppService.sendMessage(message);
        isSendMessage.value = false;
        if(result.id != 0){
          // isLoadingMessage.value = true;
          // fetchMessages();
          //msgList.reversed;
          msgList.add(result);
          //msgList.reversed;
          return true;
        }
        else{
          return false;
        }
      }
    }
    catch(e){
      // print(e);
    }
    return false;
  }
}