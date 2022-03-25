import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/ProfileScreens/profile_page.dart';
import 'package:blog_app/ProfileScreens/profile_update.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:blog_app/VitalScreens/kaji_list.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/Animation/animation_class.dart';
import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../LogRegScreens/login_page.dart';

class LandingPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaji app',
      showPerformanceOverlay: false,

      // home: LoginPage (title: 'ovivashiBatayon'),
      home: LandingPageViewExtend(),
    );
  }
}

class LandingPageViewExtend extends StatefulWidget {
  @override
  _LandingPageStateConfig createState() => _LandingPageStateConfig();
}

class _LandingPageStateConfig extends State<LandingPageViewExtend> {
  int _selectedIndex = 0;

  late PageController _pageController;
  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
  List<PublicBlogListModel> _public_blog_list =
  List<PublicBlogListModel>.empty(growable: true);

  List<PublicBlogListModel> _public_blog_list2 =
  List<PublicBlogListModel>.empty(growable: true);


  late Future<void> public_blog_future;
  late Future<void> public_blog_future2;

  @override
  initState() {
    super.initState();

    public_blog_future = CallFormsFromAPI();
    public_blog_future2 = CallFormsFromKajiAPI();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/mrdclogo.png')),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('MRDC APP'),
      ),
      resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlogListPageView()));
                        },
                        child: Card(
                          color: Colors.green,
                          child: Container(
                            margin:EdgeInsets.all(30),
                            child: Column(
                              children:[
                                Icon(Icons.person),
                                Text('Blog List'),
                              ],
                            ),

                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: ()
                            {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginConfigExtend()));
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=> const LoginPage()));
                            },
                            child: Card(
                              color: Colors.green,
                              child: Container(
                                margin:EdgeInsets.all(30),
                                child: Column(
                                  children:[

                                    Icon(Icons.person),
                                    Text('লগ ইন'),

                                  ],
                                ),

                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()
                            {
                              LoginStatusCheckToRedirectBlog();
                            },
                            child: Card(
                              color: Colors.green,
                              child: Container(
                                margin:EdgeInsets.all(30),
                                child: Column(
                                  children:[

                                    Icon(Icons.person),
                                    Text('মাই ব্লগ'),

                                  ],
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: ()
                            {
                              /*Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageView()));*/
                              LoginStatusCheckToRedirect();
                            },
                            child: Card(
                              color: Colors.green,
                              child: Container(
                                margin:EdgeInsets.all(30),
                                child: Column(
                                  children:[

                                    Icon(Icons.person),
                                    Text('Profile'),

                                  ],
                                ),

                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()
                            {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdateConfig()));

                            },
                            child: Card(
                              color: Colors.green,
                              child: Container(
                                margin:EdgeInsets.all(30),
                                child: Column(
                                  children:[

                                    Icon(Icons.person),
                                    Text('Profile Update'),

                                  ],
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),


                    ],

                  ),
           /*       FlatButton(
                    minWidth: 160,
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginConfigExtend()));
                    },
                    child: Text('লগ ইন', style: new TextStyle(color: Colors.white)),
                  ),
                  FlatButton(
                    minWidth: 160,
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyBlogListPageView()));
                    },
                    child: Text('মাই ব্লগ', style: new TextStyle(color: Colors.white)),
                  ),

                  FlatButton(
                    minWidth: 160,
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageView()));
                    },
                    child: Text('Profile', style: new TextStyle(color: Colors.white)),
                  ),

                  FlatButton(
                    minWidth: 160,
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdateConfig()));
                    },
                    child: Text('Profile Update', style: new TextStyle(color: Colors.white)),
                  ),*/

                  FlatButton(
                    minWidth: 160,
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      logout();            },
                    child: Text('লগ আউট', style: new TextStyle(color: Colors.white)),
                  ),


                ],
              ),
            )

          ),
        ),
      ),
    );
  }

  Widget ListBuilderMethod(Future<void> public_bloglist_model_fut) {
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
                if(_public_blog_list.length>0){
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      String headline = snapshot.data[index].headline;
                      String author = snapshot.data[index].author;
                    /*  String imagefile_nameString = snapshot.data[index].image;*/

                      return Expanded(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(15),

                                  child: Image.asset('assets/marrige_counseling1.jpg')),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(headline),
                              Text(author),

                            ],
                          ),
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

  Future<List<PublicBlogListModel>> CallFormsFromAPI() async {
    String error = "";
    String url = ApiUrl.MRDC_API + 'api/frontend/posts';
    Map body = {
      "type": "5",
      "limit": "",
      "title": "",
    };
    var response = await BaseClient().PostMethod(url, body);
    try {
      if (response == null) {
      } else {
        try {
          Map<String, dynamic> map = json.decode(response);
          List<dynamic> data = map["data"];

          for (int i = 0; i < 2; i++) {
            PublicBlogListModel fact = PublicBlogListModel.fromJson(data[i]);

            _public_blog_list.add(fact);
          }
        } catch (Exception) {
          print(Exception);
        }
      }
    } finally {
      print('');
    }

    return _public_blog_list;
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

                      return Expanded(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(15),

                                  child: Image.asset('assets/marrige_counseling1.jpg')),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(phone),


                            ],
                          ),
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


  void logout() {

    logoutasync();
  }


  Future<void> logoutasync() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => BlogListPageView(),
      ),

          (Route route) => false,
    );
  }

  void LoginStatusCheckToRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id_str = (prefs.getString('user_id') ?? '');

    if (user_id_str.isEmpty) {
      Navigator.of(context)
          .push(AnimationForPageRoute().createRoute(LoginConfigExtend()));
    } else {
      Navigator.of(context).push(
          AnimationForPageRoute().createRoute(ProfilePageView()));
    }
  }

  Future<void> LoginStatusCheckToRedirectBlog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id_str = (prefs.getString('user_id') ?? '');

    if (user_id_str.isEmpty) {
      Navigator.of(context)
          .push(AnimationForPageRoute().createRoute(LoginConfigExtend()));
    } else {
      Navigator.of(context).push(
          AnimationForPageRoute().createRoute(MyBlogListPageView()));
    }
  }

}

