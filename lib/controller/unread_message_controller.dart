


import 'package:get/get.dart';

import '../Services/app_service.dart';

class UnreadMessageController extends GetxController
{
  static var unreadMessage = {}.obs;

  @override
  void onInit() {
    fetchUnreadMessageNumber();
    super.onInit();
  }


  static void fetchUnreadMessageNumber() async {
    try{
      var message = await AppService.fetchUnreadMessageNumber();
      unreadMessage.value = message;
    }
    finally{

    }
  }
}