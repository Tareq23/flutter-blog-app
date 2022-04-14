import 'dart:ffi';

import 'package:blog_app/Model/message_model.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/conversation/send_message.dart';
import 'package:blog_app/conversation/user_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LogRegScreens/login_page_with_phone_number.dart';
import '../ProfileScreens/profile_page.dart';
import '../VitalScreens/blog_list.dart';
import '../VitalScreens/my_blog_list.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  List<MessageModel> messList = [
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("User Name","Text Message ","assets/default_person.jpg","Today"),
    MessageModel("Admin","Text Message ","assets/default_person.jpg","Today"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: Drawer(
      //   child: Container(
      //     color: Colors.green,
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //
      //       children: [
      //         const SizedBox(height: 20,),
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //         Container(
      //
      //           padding: const EdgeInsets.all(16.0),
      //
      //           child: InkWell(
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => BlogListPageView()));
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(Icons.dashboard),
      //                 SizedBox(width: 10),
      //                 Text("ব্লগ"),
      //               ],
      //
      //             ),
      //           ),
      //
      //         ),
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //         Container(
      //           padding: const EdgeInsets.all(16.0),
      //           child: InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   // MaterialPageRoute(builder: (context) => ProfilePageView()));
      //                   MaterialPageRoute(builder: (context) => ProfilePageView()));
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(Icons.person),
      //                 SizedBox(width: 10),
      //                 Text("প্রোফাইল"),
      //               ],
      //
      //             ),
      //           ),
      //
      //         ),
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //         Container(
      //
      //           padding: const EdgeInsets.all(16.0),
      //
      //           child: InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => MyBlogListPageView()));
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(Icons.dashboard),
      //                 SizedBox(width: 10),
      //                 Text("আমার ব্লগ"),
      //               ],
      //
      //             ),
      //           ),
      //
      //         ),
      //
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //
      //         Container(
      //
      //           padding: EdgeInsets.all(16.0),
      //
      //           child: InkWell(
      //             onTap: () {
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>Message()));
      //               /*        Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(Icons.message),
      //                 SizedBox(width: 10),
      //                 Text("ম্যাসেজ"),
      //               ],
      //
      //             ),
      //           ),
      //
      //         ),
      //
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //
      //         Container(
      //
      //           padding: EdgeInsets.all(16.0),
      //
      //           child: InkWell(
      //             onTap: () {
      //               /*        Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(Icons.money),
      //                 SizedBox(width: 10),
      //                 Text("পেমেন্ট"),
      //               ],
      //
      //             ),
      //           ),
      //
      //         ),
      //
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //
      //         Container(
      //           padding: EdgeInsets.all(16.0),
      //           child: Row(
      //             children: const [
      //               Icon(Icons.settings),
      //               SizedBox(width: 10),
      //               Text("সেটিংস"),
      //             ],
      //
      //           ),
      //
      //         ),
      //         const Divider(
      //           color: Color(0xFFc1c1c1),
      //         ),
      //
      //         // Container(
      //         //
      //         //   padding: EdgeInsets.all(16.0),
      //         //
      //         //   child: InkWell(
      //         //     onTap: () {
      //         //       logout();
      //         //     },
      //         //     child: Row(
      //         //       children: const [
      //         //         Icon(Icons.logout),
      //         //         SizedBox(width: 10),
      //         //         Text("লগ আউট"),
      //         //       ],
      //         //
      //         //     ),
      //         //   ),
      //         //
      //         // ),
      //         //
      //         // const Divider(
      //         //   color: Color(0xFFc1c1c1),
      //         // ),
      //
      //       ],
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
      //   backgroundColor: ConstValue.color,
      //   leading: Container(
      //       margin: EdgeInsets.all(10),
      //       child: Image.asset('assets/mrdclogo.png')),
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text('National MRDC'),
      // ),
      endDrawer: Drawer(
        elevation: 100,
        child: Container(
          // color: Colors.green,
          color: ConstValue.color,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(

                padding: const EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("ব্লগ",style: ConstValue.drawerTestStyle,),
                    ],

                  ),
                ),

              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => ProfilePageView()));
                        MaterialPageRoute(
                            builder: (context) => ProfilePageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("প্রোফাইল",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyBlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("আমার ব্লগ",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Message()));
                    /*        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.message,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("ম্যাসেজ",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.money,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("পেমেন্ট",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async{
                    final prefs = await SharedPreferences.getInstance();
                    final removeAccessToken = await prefs.remove('access_token');
                    final removeUserId = await prefs.remove('user_id');
                    if(removeAccessToken || removeUserId){
                      Get.to(() => const Login());
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.money,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("Logout",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        leading: IconButton( onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('আমার ব্লগ'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){
          // Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessage()));
          showSendMessageDialog(context);
        },
        child: Icon(Icons.add,color: Colors.white,size: 35,),
      ),
      body: ListView.builder(
        itemCount: messList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: ScrollPhysics(),
        itemBuilder: (context, index){
          return ConversationList(
            name: "${messList[index].name}",
            messageText: "${messList[index].messageText} ${index+1}",
            imageUrl: messList[index].imgUrl,
            time: messList[index].time,
          );
        },
      ),
    );
  }


  void showSendMessageDialog(BuildContext context)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Message',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(0),
              child: TextFormField(
                minLines: 2,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF710046),
                onPrimary: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel',style: TextStyle(fontSize: 16,),),
            ),
            const SizedBox(width: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF0053E5),
                onPrimary: Colors.white,
              ),
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text('Send',style: TextStyle(fontSize: 16,),),
            ),
          ],
        );
      },

    );
  }
}
