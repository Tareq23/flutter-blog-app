import 'dart:convert';

import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';
import '../LogRegScreens/login_page.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';


class KajiListPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaji app',
      showPerformanceOverlay: false,

      // home: LoginPage (title: 'ovivashiBatayon'),
      home: KajiListPageViewExtend(),
    );
  }
}

class KajiListPageViewExtend extends StatefulWidget {
  @override
  _KajiListPageStateConfig createState() => _KajiListPageStateConfig();
}

class _KajiListPageStateConfig extends State<KajiListPageViewExtend> {

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton( onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('কাজী লিস্ট'),
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
                        Text('কাজী লিস্ট', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                        Column(children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 700,
                            width: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Color(0x00303F9F),

                            ),

                            child: ListBuilderKajiMethod(public_blog_future2),
                          ),
                          SizedBox(height: 10),


                        ],),
                   
                      ],

                    ),


                  ],
                ),
              )

          ),
        ),
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
                        img = imagefile_nameString;
                      }
                      else
                      {
                        img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      }


                      return Expanded(
                        child: Card(
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
}