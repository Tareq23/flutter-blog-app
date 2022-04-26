import 'dart:convert';

import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';

// import 'landing_page.dart';
// import '../LogRegScreens/login_page.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:get/get.dart';


class KajiListPageViewExtend extends StatefulWidget {
  @override
  _KajiListPageStateConfig createState() => _KajiListPageStateConfig();
}

class _KajiListPageStateConfig extends State<KajiListPageViewExtend> {

  final profileController = Get.put(ProfileController());

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();

  List<PublicBlogListModel> _public_blog_list2 =
  List<PublicBlogListModel>.empty(growable: true);


  late Future<void> public_blog_future2;

  @override
  initState() {
    super.initState();

    public_blog_future2 = CallFormsFromKajiAPI();
  }

  @override
  Widget build(BuildContext context) {
    profileController.fetchKajiList();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        elevation: 0,
        leading: IconButton( onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('কাজী লিস্ট'),
      ),
      resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      body: SafeArea(

        child: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          width: screenSize.width,
          height: screenSize.height,

          child: Obx((){
            if(profileController.kajiList.isEmpty){
              return const Center(child: CircularProgressIndicator(color: ConstValue.color,),);
            }
            else{
              return ListView.builder(
                itemCount: profileController.kajiList.length,
                itemBuilder: (context,index){
                  return Container(
                    // color: Colors.red,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              child: const Image(
                                image: AssetImage('assets/default_person.jpg'),
                              ),
                            )
                        ),
                        const SizedBox(width: 30,),
                        Container(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text("${profileController.kajiList[index].name}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(
                                  0xFF181818)),),
                              const SizedBox(height: 15,),

                              Text("${profileController.kajiList[index].address}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(
                                  0xFF181818)),),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
        ),

        // child: SingleChildScrollView(
        //   reverse: false,
        //   child: Container(
        //       margin: const EdgeInsets.all(15),
        //       child: Center(
        //         child: Column(
        //           children: [
        //             Column(
        //               children: [
        //                 Column(children: [
        //                   Container(
        //                     margin: EdgeInsets.all(10),
        //                     height: 700,
        //                     width: 500,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(2.0),
        //                       color: Color(0x00303F9F),
        //
        //                     ),
        //                     child: ListBuilderKajiMethod(public_blog_future2),
        //                   ),
        //                   SizedBox(height: 10),
        //
        //
        //                 ],),
        //
        //               ],
        //
        //             ),
        //
        //
        //           ],
        //         ),
        //       )
        //
        //   ),
        // ),
      ),
    );
  }


  Widget ListBuilderKajiMethod(Future<void> public_bloglist_model_fut) {
    return FutureBuilder<void>(
      future: public_bloglist_model_fut,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        debugPrint('Builder');
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: new Text('Loading...'));
            else {
              if (snapshot.hasData) {
                if(_public_blog_list2.length>0){
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      String phone = snapshot.data[index].phone;

                      String imagefile_nameString = snapshot.data[index].image;

                      String img;


                      if(imagefile_nameString!=null){
                        //img = imagefile_nameString;
                        img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      }
                      else
                      {
                        img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      }


                      return Card(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        elevation: 5,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.all(15),

                                child: Container(
                                    height: 200,
                                    child: Image.network(img))),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("01700000000"),


                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                else{
                  return Center(child: new Text('কোন তথ্য পাওয়া যায় নি', style: new TextStyle(color: Colors.grey, fontSize: 20)));
                }

              } else
                return Center(child: CircularProgressIndicator());
            }
            break;

          default:
            debugPrint("Snapshot " + snapshot.toString());
            return Center(child: new Text('Loading...'));
        }
      },
    );
  }




  Future<List<PublicBlogListModel>> CallFormsFromKajiAPI() async {
    String error = "";
    String url = ApiUrl.MRDC_API + 'api/frontend/users?role=3&name&address';



    Map body = {
      "role": "3",
      "name": "",
      "address": "",
    };

    var response = await BaseClient().PostMethod(url, body);
    //print(response.body);
    try {
      if (response == null) {
      } else {
        try {
          Map<String, dynamic> map = json.decode(response);
          List<dynamic> data = map["data"];

          for (int i = 0; i < 2; i++) {
            PublicBlogListModel fact = PublicBlogListModel.fromJson(data[i]);

            _public_blog_list2.add(fact);
          }
        } catch (Exception) {
          print(Exception);
        }
      }
    } finally {
      print('');
    }

    return _public_blog_list2;
  }
}