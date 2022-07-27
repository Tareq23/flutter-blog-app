import 'dart:convert';
import 'dart:developer';

import 'package:blog_app/LogRegScreens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:flutter/widgets.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../VitalScreens/landing_page.dart';

class RegistrationConfig extends StatelessWidget {
  const RegistrationConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'রেজিস্ট্রেশন',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegistrationPageViewExtend(),
    );
  }
}

class RegistrationPageViewExtend extends StatefulWidget {
  const RegistrationPageViewExtend({Key? key}) : super(key: key);

  @override
  _RegistrationPageStateConfig createState() => _RegistrationPageStateConfig();
}

class _RegistrationPageStateConfig extends State<RegistrationPageViewExtend> {


  final _globalScaffoldKey = GlobalKey<ScaffoldState>();
  final items = ['item 1', 'item 2'];
  String? selectCityValue;
  String? selectJobValue;

  String? name = "";
  String password = "";
  String confirmPassword = "";
  String userId = "";
  String code = "";



  final _formKey = GlobalKey<FormState>();




  late Future<void> DropCityFuture;
  late Future<void> DropJobFuture;

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,

      body: Scaffold(resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton( onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
          }, icon: Icon(Icons.arrow_back_sharp,)),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Registration'),
        ),
        key: _globalScaffoldKey,
        body: SingleChildScrollView(
          reverse: false,
          child: Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Card(
                          margin:
                          const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: SizedBox(
                                  height: 40,
                                  width: 500,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.person),
                                          const SizedBox(width: 10),
                                          const Text(
                                              "আগ্রহী প্রার্থী রেজিস্ট্রেশন"),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Color(0xFFc1c1c1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: SizedBox(
                                  height: 40,
                                  width: 500,
                                  child: TextFormField(
                                    validator: (value) {
                                      // add your custom validation here.
                                      if (value == null || value.isEmpty) {
                                        return 'নাম প্রয়োজন';
                                      } else {
                                        name = value;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      label: Text(
                                        'নাম',
                                      ),
                                      labelStyle:
                                      TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: SizedBox(
                                  height: 40,
                                  width: 500,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'ইমেইল/মোবাইল প্রয়োজন';
                                      } else {
                                        userId = value;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        'ইমেইল/মোবাইল*',
                                      ),
                                      labelStyle:
                                      TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: SizedBox(
                                  height: 40,
                                  width: 500,
                                  child: TextFormField(
                                    validator: (value) {
                                      // add your custom validation here.
                                      if (value!.isEmpty) {
                                        return 'পাসওয়ার্ড প্রয়োজন';
                                      } else if (value.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      } else {
                                        password = value;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        'পাসওয়ার্ড*',
                                      ),
                                      labelStyle:
                                      TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                          Icons.remove_red_eye),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: SizedBox(
                                  height: 40,
                                  width: 500,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'কনফার্ম পাসওয়ার্ড প্রয়োজন';
                                      } else if (value != password) {
                                        return 'Not matched!';
                                      } else {
                                        confirmPassword = value;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        'কনফার্ম পাসওয়ার্ড*',
                                      ),
                                      labelStyle:
                                      TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                          Icons.remove_red_eye),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      height: 30,
                                      width: 135,
                                      child: MaterialButton(
                                        minWidth: 500,
                                        height: 50,
                                        color: Colors
                                            .white /*Color(0xFF76ab29)*/,
                                        onPressed: () /*async*/ {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginConfigExtend()));
                                        },
                                        child: const Text(
                                          'লগ ইন',
                                          style:
                                          TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 135,
                                      child: MaterialButton(
                                        minWidth: 500,
                                        height: 50,
                                        color: Colors
                                            .green /*Color(0xFF76ab29)*/,
                                        onPressed: () /*async*/ async {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(content: Text(
                                                  'Processing Data')),
                                            );

                                            String error = await RegistrationHit(
                                                name??'default value', userId, password,
                                                confirmPassword);

                                            if (error == "") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Error while registration! Please Try again.")),
                                              );
                                            } else {
                                            phoneVerification(userId);
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'নিবন্ধন',
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<String> RegistrationHit(String nameStr, String userId, String pwd, String confirmPwd) async {
    String error = "";
    String url = ApiUrl.MRDC_API+'applicant-agency';
    String a ='';

    Map body = {

      "name": nameStr,
      "email": userId,
      "password": pwd,
      "confirm_password": confirmPwd,
      "agency": "agency",

    };

    var regResp = await BaseClient().PostMethod(url, body);
    var regResp1 = "";


    try {
      if (regResp == null) {} else {
        error = regResp.toString();
      }
    } finally {}

    return error;
  }

  void phoneVerification(String UserId) {

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('এসএমএস কোড এবং নতুন পাসওয়ার্ড বসান!'),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
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

                      ],

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
                  if (_formKey.currentState!.validate()) {
                    String response = await CallFormsFromAPIPhoneVerification(code) as String;

                    var test = '';

                    if (response.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("কাজটি সম্পন্ন হয়নি")),
                      );

                    }
                    else {
                      //dialogPass();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("কাজটি সফলভাবে সম্পন্ন হয়েছে")),
                      );
                       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginConfigExtend()));
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

  Future<String> CallFormsFromAPIPhoneVerification(String code) async {
    String error = "";
    String url =
        ApiUrl.MRDC_API+'applicant-agency/activation/'+userId+'/'+code;



    var response = await BaseClient().GetMethod(url);

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
//
}

