
import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashConfig extends StatefulWidget {

  @override
  _SplashPageStateConfig createState() => _SplashPageStateConfig();
}

class _SplashPageStateConfig extends State<SplashConfig>{

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2000), () {
      _checkAccessToken();
    });
  }


  void _checkAccessToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    if(accessToken == null){
      Navigator.push(context,MaterialPageRoute(builder: (context) => const Login()));
    }else{
      setState(() {
        Navigator.push(context,MaterialPageRoute(builder: (context) => BlogListPageView()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/mrdclogo.png'),
                const Text(
                  'ন্যাশনাল ম্যারেজ রেজিষ্ট্রার', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

