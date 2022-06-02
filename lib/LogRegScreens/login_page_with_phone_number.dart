

import 'dart:convert';

import 'package:blog_app/LogRegScreens/registration.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../VitalScreens/landing_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _requiredValue = "মোবাইল প্রয়োজন";
  String userNumber = " ";
  String otpCode = "";
  bool _isValidNumber = false;
  bool _isLoadingOTP = false;
  bool _isLoginButtonClicked = false;

  void init() async
  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String accessToken = (sp.getString('access_token')??"");
    if(accessToken != ""){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogListPageView()));
    }
  }

  @override
  void initState() {
    init();
    phoneNumberController.addListener(_getPhoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
  void _getPhoneNumber()
  {
    setState(() {
      userNumber = phoneNumberController.text;
    });
  }

  void _checkUserNumber() async
  {
    String api_link = "https://api.nationalmrdc.com/applicant-agency-mobile";
    var url = Uri.parse(api_link);
    Map data = {
      'phone' : userNumber
    };
    var response = await http.post(url, body: data);
    if(response.statusCode == 200)
    {
      var responseData = jsonDecode(response.body);
      if(responseData['phone'] == userNumber){
        setState(() {
          _isValidNumber = true;
        });
      }
      else{
        showToastMessage('ভুল নাম্বার দিয়েছেন!');
      }
    }
    else if(response.statusCode == 500){
      // showToastMessage('ভুল নাম্বার দিয়েছেন!');
      // showToastMessage(response.body.toString());
      showToastMessage("Internal Server Error");
    }
    // print(response.body);
    // print(response.statusCode.toString());
  }

  void showToastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _checkOTP(BuildContext context)
  {
    setState(() {
      _isLoadingOTP = true;
    });
    getRequest(context);
  }

  void getRequest(BuildContext context) async
  {
    var url = "https://api.nationalmrdc.com/applicant-agency-mobile/activation/$userNumber/$otpCode";
    final response = await http
          .get(Uri.parse(url));
    var responseJson = jsonDecode(response.body);
    if(response.statusCode == 200) {
      if(responseJson['access_token'].toString().length > 10){
        storeLoginAccessToken(responseJson['access_token'].toString(),responseJson['user']['id']);
      }
    }
    setState(() {
      _isLoadingOTP = false;
    });
  }


  void storeLoginAccessToken(String token,int userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    prefs.setInt('user_id', userId);
    String accessToken = (prefs.getString('access_token')??"default");
    if(accessToken != "default"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogListPageView()));
    }
    else{
      showToastMessage('ওটিপি সঠিক নয়');
    }

  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenSize.width * 0.4,
                  height: screenSize.width * 0.4,
                  margin: EdgeInsets.only(top: (screenSize.height * 0.08)),
                  child: const Image(
                    image: AssetImage("assets/bmrplogo.png"),
                  ),
                ),
                _isValidNumber == false ?
                _loginCard(context) :
                _otpCard(context)
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _loginCard(BuildContext context)
  {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.9,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(
        left: (screenSize.width * 0.05),
        right: (screenSize.width * 0.05),
        top: (screenSize.width * 0.1),
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.green.shade300,
                blurRadius: 25
            ),
            BoxShadow(
                color: Colors.red.shade300,
                blurRadius: 9
            )
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Card(
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: ConstValue.color
            ),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "স্বাগতম",
                      style: TextStyle(
                        fontSize: 25,
                          color: Color(0xFFD5D4D4),
                      ),
                    )),
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "ন্যাশনাল ম্যারেজ রেজিষ্ট্রার",
                //     style: TextStyle(fontSize: 14,color: Color(0xFFD5D4D4)),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: phoneNumberController,
                      // keyboardType: TextInputType.number,
                      style: const TextStyle(letterSpacing:1.2,fontSize: 16,fontWeight: FontWeight.w500,color: Color(
                          0xFFFFFFFF)),
                      decoration: InputDecoration(
                        hintText: "মোবাইল নাম্বার",
                        hintStyle: const TextStyle(color: Color(0xFFD0CFCF),fontWeight: FontWeight.w400,fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF6C6B6B),width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFAAAAAA))
                        ),
                        labelText: "মোবাইল নাম্বার",
                        labelStyle: const TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.w400),
                      ),
                      validator: (text) {
                        bool check=true;
                        String number = text.toString();
                        int v_0 = "0".codeUnits.first;
                        int v_9 = "9".codeUnits.first;
                        for(int i=0; i<number.length; i++)
                        {
                          int val = number[i].codeUnits.first;
                          if(val>v_9 || val<v_0)
                          {
                            return "সঠিক নাম্বার দিন";
                          }
                        }
                        if (text == null || text.isEmpty) {
                          return 'আপনার মোবাইল নাম্বার দিন';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                _isLoginButtonClicked == false ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: screenSize.width * 0.3,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8)
                      ),
                      onPressed: () async{

                        if (_formKey.currentState!.validate()) {

                          /*app needs */

                          setState(() {
                            _isLoginButtonClicked = true;
                          });
                          _checkUserNumber();

                          /*For check*/
                          // setState(() {
                          //   _isValidNumber = true;
                          // });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('পরবর্তী',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),

                          Icon(Icons.arrow_forward,size: 28,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ) : const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                    strokeWidth: 3,
                    backgroundColor: Colors.black87,
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpCard(BuildContext context)
  {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      margin: EdgeInsets.only(
        left: (screenSize.width * 0.05),
        right: (screenSize.width * 0.05),
        top: (screenSize.width * 0.1),
      ),
      decoration: BoxDecoration(
          color: ConstValue.color,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20,bottom: 30),
            child: const Text('ওটিপি দিন',style: TextStyle(color: Colors.black,fontSize: 18),),
          ),
          VerificationCode(
            length: 6,
            keyboardType: TextInputType.number,
            underlineColor: Colors.red,
            autofocus: true,
            underlineUnfocusedColor: Colors.blueGrey,
            underlineWidth: 2.5,
            textStyle: const TextStyle(fontSize: 18),
            fillColor: Colors.greenAccent,
            onEditing: (bool value) {  },
            onCompleted: (value){
              setState(() {
                otpCode = value;
              });
            },
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: screenSize.width * 0.35,
            child: MaterialButton(
              onPressed: (){
                if(otpCode.length == 6)
                {
                  _checkOTP(context);

                  /*for check*/
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BlogListPageView()));
                }
              },
              color: Colors.red,
              child: _isLoadingOTP ? const CircularProgressIndicator(
                backgroundColor: Colors.black,
                strokeWidth: 2.5,
                color: Colors.white,
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('লগইন',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_forward_rounded,size: 30,color: Colors.white,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

