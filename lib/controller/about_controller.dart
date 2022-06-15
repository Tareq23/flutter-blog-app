


import 'package:blog_app/Services/app_service.dart';
import 'package:get/get.dart';

class AboutController extends GetxController
{
  var isLoading = true.obs;
  var content = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchAboutData();
    super.onInit();
  }

  void fetchAboutData() async
  {
    if(isLoading.value){
      var result = await AppService.fetchAbout();
      isLoading.value = false;
      content.value = result;
    }
     // "<p>Hello about section</p>";
  }

}