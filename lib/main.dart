// @dart=2.9

import 'package:blog_app/VitalScreens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:get/get.dart';
import 'Animation/animation_class.dart';
import 'VitalScreens/landing_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainConfig());
}

class MainConfig extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'ovivashiBatayon',
    //   showPerformanceOverlay: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     primaryColor: const Color(0xff262545),
    //     primaryColorDark: const Color(0xff201f39),
    //     brightness: Brightness.light,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //
    //   ),
    //   // home: LoginPage (title: 'ovivashiBatayon'),
    //   home: MainConfigExtend (),
    // );
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ovivashiBatayon',
        showPerformanceOverlay: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xff262545),
          primaryColorDark: const Color(0xff201f39),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        // home: LoginPage (title: 'ovivashiBatayon'),
        home: MainConfigExtend (),
    );
  }
}

class MainConfigExtend extends StatefulWidget {
/*  LoginPage({Key key, this.title}) : super(key: key);

  final String title;*/

  @override
  _MainPageStateConfig createState() => _MainPageStateConfig();
}

class _MainPageStateConfig extends State<MainConfigExtend> {

  @override
  initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {


    // Navigator.of(context).push(AnimationForPageRoute().createRoute(LandingPageView()));


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(resizeToAvoidBottomInset: false,

      //body: LoginPageView(),//HomePage(),
      //body: SplashPageView(),//HomePage(),
      body: SplashConfig(),//HomePage(),
    );
  }

}
