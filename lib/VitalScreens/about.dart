import 'package:blog_app/controller/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../Services/color.dart';
import '../Services/common_widgets.dart';
import '../controller/network_controller.dart';

class About extends StatelessWidget {
   About({Key? key}) : super(key: key);

  AboutController aboutController = Get.put(AboutController());
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'বিএমআরপি সম্পর্কে',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              wordSpacing: 2,
              letterSpacing: 1.5),
        ),
        backgroundColor: ConstValue.color,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        width: screenSize.width,
        height: screenSize.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Obx((){
            if (NetworkController.networkError.value &&
                aboutController.content.isEmpty){
              return Center(
                child: NetworkNotConnect(page: "about",controller: aboutController,),
              );
            }else if(aboutController.isLoading.value){
              return Container(
                padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  width: screenSize.width,
                  height: screenSize.height,
                  child: const Center(child: CircularProgressIndicator())
              );
            }
            else if(aboutController.content.isNotEmpty){
              return Html(
                data: aboutController.content.value,
              );
            }
            else{
              return EmptyListData(page: "about", controller: aboutController);
            }
          }),
        ),
      ),
    );
  }
}
