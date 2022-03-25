import 'package:flutter/material.dart';

import '../ProfileScreens/profile_page.dart';
import '../VitalScreens/my_blog_list.dart';
import 'message_ui.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: Colors.green,
          child: ListView(
            padding: EdgeInsets.zero,

            children: [
              const SizedBox(height: 20,),
              const Divider(
                color: Color(0xFFc1c1c1),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => ProfilePageView()));
                        MaterialPageRoute(builder: (context) => ProfilePageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text("প্রোফাইল"),
                    ],

                  ),
                ),

              ),
              const Divider(
                color: Color(0xFFc1c1c1),
              ),
              Container(

                padding: const EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyBlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard),
                      SizedBox(width: 10),
                      Text("আমার ব্লগ"),
                    ],

                  ),
                ),

              ),

              const Divider(
                color: Color(0xFFc1c1c1),
              ),

              Container(

                padding: EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Message()));
                    /*        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.message),
                      SizedBox(width: 10),
                      Text("ম্যাসেজ"),
                    ],

                  ),
                ),

              ),

              const Divider(
                color: Color(0xFFc1c1c1),
              ),

              Container(

                padding: EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    /*        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.money),
                      SizedBox(width: 10),
                      Text("পেমেন্ট"),
                    ],

                  ),
                ),

              ),

              const Divider(
                color: Color(0xFFc1c1c1),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text("সেটিংস"),
                  ],

                ),

              ),
              const Divider(
                color: Color(0xFFc1c1c1),
              ),

              // Container(
              //
              //   padding: EdgeInsets.all(16.0),
              //
              //   child: InkWell(
              //     onTap: () {
              //       logout();
              //     },
              //     child: Row(
              //       children: const [
              //         Icon(Icons.logout),
              //         SizedBox(width: 10),
              //         Text("লগ আউট"),
              //       ],
              //
              //     ),
              //   ),
              //
              // ),
              //
              // const Divider(
              //   color: Color(0xFFc1c1c1),
              // ),

            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/mrdclogo.png')),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('National MRDC'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('Description',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: Colors.lightBlue.shade700),),
                  TextFormField(
                    minLines: 2,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Submit',style: TextStyle(fontSize: 16,),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
