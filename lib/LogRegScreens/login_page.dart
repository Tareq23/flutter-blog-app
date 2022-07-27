import 'dart:convert';

import 'package:blog_app/VitalScreens/landing_page.dart';
import 'package:blog_app/LogRegScreens/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/base_client.dart';

void main() {
  runApp(MaterialApp(home: LoginConfigExtend()));
}

class LoginConfigExtend extends StatefulWidget {
  @override
  _LoginPageStateConfig createState() => _LoginPageStateConfig();
}

class _LoginPageStateConfig extends State<LoginConfigExtend> {
  late String user_id_str;
  late String user_pwd_str;

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  String user_id = "";
  String password = "";
  String email = "";
  String code = "";
  String poppass = "";
  String popconpass = "";

  @override
  void initState() {
    super.initState();
  }

  void userLoginStatusCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id_str = (prefs.getString('user_id') ?? '');
    user_pwd_str = (prefs.getString('user_pwd') ?? '');

    // if (user_id_str.isEmpty) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
    //
    // } else {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton( onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Log in'),
      ),

      body: Scaffold(
        key: _globalscaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: false,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Card(
                      margin: EdgeInsets.all(30),
                      color: Colors.cyan,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                                 children: [
                                   Align(
                                       alignment: Alignment.centerLeft,
                                       child: Text(
                                         "স্বাগতম",
                                         style: new TextStyle(
                                           fontSize: 25,
                                           color: Colors.black,
                                         ),
                                       )),
                                   Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       "কাজী তে",
                                       style: new TextStyle(fontSize: 18),
                                     ),
                                   ),
                                   SizedBox(height: 15),
                                   Container(
                                     width: 220,
                                     child: TextFormField(
                                       validator: (value) {
                                         if (value == null || value.isEmpty) {
                                           return ' ইমেইল/মোবাইল প্রয়োজন';
                                         } else {
                                           user_id = value;
                                         }
                                       },
                                       style: TextStyle(color: Colors.black),
                                       onChanged: (v) {
                                         //_controller.userExists = "unique".obs;
                                         /*_controller.updateButtonStatus();*/
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
                                               color: Colors.yellow,
                                               width: 2.0),
                                         ),
                                         fillColor: Colors.white,
                                         label: const Text(
                                           'ইমেইল/মোবাইল',
                                         ),
                                         labelStyle:
                                         TextStyle(color: Colors.black),
                                       ),
/*
                               validator: (v) {
                               if (v!.isEmpty)
                                 return "মোবাইল নাম্বার অবশ্যক";
                               // else if (_controller.unique_by_mobile ==
                               //     "not_unique".obs) return "User Not Exists";
                               return null;
                               },*/
                                     ),
                                   ),
                                   SizedBox(
                                     height: 20,
                                   ),
                                   Container(
                                     width: 220,
                                     child: TextFormField(
                                       validator: (value) {
                                         // add your custom validation here.
                                         if (value!.isEmpty) {
                                           return ' পাসওয়ার্ড প্রয়োজন';
                                         } else if (value.length < 8) {
                                           return 'পাসওয়ার্ড কমপক্ষে 8 অক্ষরের হতে হবে';
                                         } else {
                                           password = value;
                                         }
                                       },
                                       style: TextStyle(color: Colors.black),
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
                                               color: Colors.yellow,
                                               width: 2.0),
                                         ),
                                         label: const Text(
                                           'পাসওয়ার্ড',
                                         ),
                                         labelStyle:
                                         TextStyle(color: Colors.black),
                                       ),
                                     ),
                                   ),

                                   Row(
                                     children: [
                                       InkWell(
                                         onTap: () {
                                           dialog();
                                         },
                                         child: Text(
                                           "পাসওয়ার্ড ভুলে গেছেন?",
                                           style: TextStyle(color: Colors.black),
                                         ),
                                       ),

                                       Container(
                                         margin: EdgeInsets.all(10),
                                         child: MaterialButton(
                                           minWidth: 100,
                                           height: 45,
                                           color: Colors.green,
                                           onPressed: () async {
                                             // Validate returns true if the form is valid, or false otherwise.
                                             if (_formKey.currentState!
                                                 .validate()) {
                                               String error = (await LoginHit(
                                                   user_id, password));

                                               if (error == "") {
                                                 ScaffoldMessenger.of(context)
                                                     .showSnackBar(
                                                   const SnackBar(
                                                       content: Text(
                                                           "সঠিক তথ্য দিন")),
                                                 );
                                               } else {
                                                 userLoginStatusCheck();
                                               }
                                             }
                                           },


                                           child: Row(
                                             children: [
                                               Text(
                                                 'লগইন',
                                                 style: TextStyle(
                                                     color: Colors.black),
                                               ),
                                               Icon(
                                                 Icons.arrow_right,
                                               )
                                             ],
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                   InkWell(
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationConfig()));
                                     },
                                     child: Container(
                                       margin: EdgeInsets.all(10),
                                       height: 50,
                                       width: 150,
                                       decoration: BoxDecoration(
                                         border:
                                         Border.all(color: Colors.black),
                                         borderRadius:
                                         BorderRadius.circular(5.0),
                                       ),
                                       child: Row(
                                         children: [
                                           Container(
                                             margin: EdgeInsets.all(5),
                                             child: Icon(
                                               Icons
                                                   .account_circle_outlined,
                                               color: Colors.black,
                                             ),
                                           ),
                                           SizedBox(
                                             width: 8,
                                           ),
                                           Text(
                                             'রেজিস্ট্রেশন',
                                             style: TextStyle(
                                                 color: Colors.black),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ), //HomePage(),
    );
  }

  Future<String> LoginHit(String phone, String pass) async {
    final prefs = await SharedPreferences.getInstance();

    String error = "";
    String url = ApiUrl.MRDC_API+'oauth/login';

    Map body = {
      "grant_type": "password",
      "client_id": "2",
      "client_secret": "F1YHP5NkNMLNWjgwZbZ6ATvkXYo4rQPsrCDigbbR",
      "scope": "",
      "username": phone,
      "password": pass,
    };

    var loginResp = await BaseClient().PostMethod(url, body);

    try {
      if (loginResp == null) {
      } else {
        try {
          Map<String, dynamic> map = json.decode(loginResp);
          String tokenStr = map["access_token"];

          Map<String, dynamic> userObj = map["user"];
          String userId = userObj["id"].toString();

          prefs.setString("user_tkn", tokenStr);
          prefs.setString("user_id_identity", userId);

          print(tokenStr);
        } catch (Exception) {
          print(Exception);
        }

        //caching handle
        prefs.setString("user_id", phone);
        prefs.setString("user_pwd", pass);
        error = loginResp.toString();
      }
    } finally {}

    return error;
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('পাসওয়ার্ড ভুলে গেছেন?'),
            content: Form(
              key: _formKey2,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'এই ঘরটি অবশ্য পূরণীয়';
                  } else {
                    email = value;
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  fillColor: Colors.black,
                  label: Text(
                    'ইমেইল/মোবাইল',
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            actions: [
              MaterialButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('বাতিল করুন'),
              ),
              MaterialButton(
                textColor: Colors.black,
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey2.currentState!.validate()) {
                    String response = await CallFormsFromAPI(email);

                    var test = '';

                    if (response.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("কাজটি সম্পন্ন হয়নি")),
                      );
                    }
                    else {
                      dialogPass();
                    }
                  }
                },
                child: const Text('পাঠান'),
              ),

            ],
          ),
        );
      },
    );
  }

  Future<String> CallFormsFromAPI(String email) async {
    String error = "";
    String url = ApiUrl.MRDC_API+'applicant-agency/forgot-password';

    Map body = {
      "email": email,
    };

    var response = await BaseClient().PostMethod(url, body);

    try {
      if (response == null) {}
      else {
        try{
          error=response.toString();
        }
        catch(Exception){
          print(Exception);
        }

      }
    } finally {}

    return error;
  }

  Future<String> CallFormsFromAPIPop(String code, String poppass, String email) async {
    String error = "";
    String url =
        ApiUrl.MRDC_API+'applicant-agency/reset-password';

    Map body = {
      "code": code,
      "password":poppass,
      "phone":email,

    };

    var response = await BaseClient().PostMethod(url, body);

    try {
      if (response == null) {}
      else {
        try{
          error = response.toString();
        }
        catch(Exception){
          print(Exception);
        }

      }
    } finally {}

    return error;
  }

  void dialogPass() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('এসএমএস কোড এবং নতুন পাসওয়ার্ড বসান!'),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Form(
                    key: _formKey3,
                    child: Flexible(
                      child: Column(
                        children:[
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'এই ঘরটি অবশ্য পূরণীয়';
                              } else {
                                code = value;
                              }
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.black,
                              label: const Text(
                                'কোড',
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'এই ঘরটি অবশ্য পূরণীয়';
                              } else {
                                poppass = value;
                              }
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.black,
                              label: const Text(
                                'পাসওয়ার্ড',
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'এই ঘরটি অবশ্য পূরণীয়';
                              }
                              else if (value != poppass) {
                                return ' পাসওয়ার্ড মিল নেই';
                              }
                              else {
                                popconpass = value;
                              }
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.black,
                              label: const Text(
                                'কনফার্ম পাসওয়ার্ড',
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),

                ],
              ),

            ),
            actions: [
              MaterialButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('বাতিল করুন'),
              ),
              MaterialButton(
                textColor: Colors.black,
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey3.currentState!.validate()) {
                    String response = await CallFormsFromAPIPop(code,poppass, email) as String;

                    var test = '';

                    if (response.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("কাজটি সম্পন্ন হয়নি")),
                      );

                    }
                    else {
                      //dialogPass();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("পাসওয়ার্ড রিসেট সফলভাবে সম্পন্ন হয়েছে")),
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));

                    }
                  }
                },
                child: Text('সাবমিট'),
              ),

            ],

          ),
        );
      },
    );
  }
}

