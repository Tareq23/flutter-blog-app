
import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'landing_page.dart';




// class SplashConfig extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kaji App',
//       showPerformanceOverlay: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         primaryColor: const Color(0xff262545),
//         primaryColorDark: const Color(0xff201f39),
//         brightness: Brightness.light,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//
//       ),
//       // home: LoginPage (title: 'ovivashiBatayon'),
//       home: SplashConfigExtend (),
//     );
//   }
// }

class SplashConfig extends StatefulWidget {

  @override
  _SplashPageStateConfig createState() => _SplashPageStateConfig();
}

class _SplashPageStateConfig extends State<SplashConfig>{

  @override
  void initState() {
    super.initState();

    //userLoginStatusCheck();

    Future<void>.delayed(const Duration(milliseconds: 2000), () {
      _checkAccessToken();
    });
  }


  void _checkAccessToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('check_token');
    String? accessToken = prefs.getString('access_token');
    if(accessToken == null){
      Navigator.push(context,MaterialPageRoute(builder: (context) => const Login()));
    }else{
      // print("Access Token : $accessToken");
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
                  'MRDC App', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
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

