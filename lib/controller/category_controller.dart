import 'package:blog_app/Model/category_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
{

  var catList = <CategoryModel>[].obs;

  var selectCategoryForSearch = CategoryModel(0, "Select Category").obs;

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  Future<void> fetchCategory() async {
    try{
      var _catList = await AppService.fetchCategory();
      catList.assignAll(_catList);
      if(catList.isNotEmpty){
        selectCategoryForSearch.value = catList[0];
      }
    }
    finally{

    }
  }

}