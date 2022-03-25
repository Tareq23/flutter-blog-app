import 'package:blog_app/Services/app_service.dart';
import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';


import 'landing_page.dart';
import '../LogRegScreens/login_page.dart';

// class UpdateMyBlogListPageView extends StatelessWidget {
//
//   late final String headline;
//   late final String content;
//   late final String id;
//
//
//   UpdateMyBlogListPageView(this.headline, this.content, this.id);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kaji app',
//       showPerformanceOverlay: false,
//
//       // home: LoginPage (title: 'ovivashiBatayon'),
//       home: UpdateMyBlogListPageViewExtend(headline,content,id),
//     );
//   }
// }
//
// class UpdateMyBlogListPageViewExtend extends StatefulWidget {
//
//   late final String headline;
//   late final String content;
//   late final String id;
//
//
//   UpdateMyBlogListPageViewExtend(this.headline, this.content, this.id);
//   @override
//   _UpdateMyBlogListPageStateConfig createState() => _UpdateMyBlogListPageStateConfig(headline, content,id);
// }
//
// class _UpdateMyBlogListPageStateConfig extends State<UpdateMyBlogListPageViewExtend>

class UpdateMyBlogListPageView extends StatelessWidget {

  var _postController = Get.put(PostController());

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


  String? headline;
  String? content;
  String? id;

  late String newheadline;
  late String newdescription;

  late Future<void> createFuture;

  late String userTkn;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton( onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => MyBlogListPageView()));
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('ব্লগ আপডেট করুন'),
      ),
      resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Obx((){
            headline = _postController.postDetails.value.headline.toString();
            content = _postController.postDetails.value.content.toString();
            id = _postController.postDetails.value.id.toString();
            _postController.updatePost.value = _postController.postDetails.value;
            return  Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue:headline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'হেডলাইন প্রয়োজন';
                            } else {
                              newheadline = value;
                            }
                          },
                          style: TextStyle(color: Colors.black),
                          onChanged: (v) {
                            //_controller.userExists = "unique".obs;
                            /*_controller.updateButtonStatus();*/
                            _postController.updatePost.value.headline = v;
                          },
                          decoration: const InputDecoration(
                            enabledBorder:
                            const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black,
                            label: const Text(
                              'নাম/টাইটেল/হেডলাইন',
                            ),
                            labelStyle:
                            TextStyle(color: Colors.black),
                          ),

                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          minLines: 3,
                          maxLines: null,
                          initialValue:content,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' বিবরণ প্রয়োজন';
                            } else {
                              newdescription = value;
                            }
                          },
                          style: TextStyle(color: Colors.black),
                          onChanged: (v) {
                            //_controller.userExists = "unique".obs;
                            /*_controller.updateButtonStatus();*/
                            _postController.updatePost.value.content = v;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 55.0, horizontal: 20.0),
                            enabledBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black,
                            label: const Text(
                              'বিবরণ',
                            ),
                            labelStyle:
                            TextStyle(color: Colors.black),
                          ),

                        ),


                        SizedBox(height: 20,),

                        FlatButton(
                          minWidth: 160,
                          height: 45,
                          color: Color(0xfffec810),
                          onPressed: () async {

                            if (_formKey.currentState!
                                .validate()) {
                              // String error = ( await CallFormsFromUpdateBlogAPI(headline, content,id));

                              // if (error == "") {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(
                              //     const SnackBar(
                              //         content: Text(
                              //             "সঠিক তথ্য দিন")),
                              //   );
                              // }

                              _postController.postUpdate();

                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text("কাজটি সম্পন্ন হয়েছে")),
                              // );

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyBlogListPageView()));

                            }
                          },

                          child: Center(
                            child: Text(
                              'আপডেট',
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )

              ),
            );
          }),
        ),
      ),
    );
  }



  Future<String> CallFormsFromUpdateBlogAPI(String headline, String content, String id) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    userTkn = (prefs.getString('user_tkn') ?? '');
    String url = ApiUrl.MRDC_API + 'api/post/'+id;

    Map body = {
      "content": newdescription,
      "headline": newheadline,
      "type":"5",
      "status":"1",
    };

    var response = await BaseClient().PostMethodWithHeader(url, userTkn, body);

    return response;

  }
}