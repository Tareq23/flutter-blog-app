
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:blog_app/VitalScreens/kaji_list.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:blog_app/controller/assistant_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../LogRegScreens/login_page_with_phone_number.dart';
import '../ProfileScreens/profile_page.dart';
import '../Services/color.dart';
import '../Services/common_widgets.dart';
import '../controller/network_controller.dart';
import '../conversation/message_ui.dart';
import 'about.dart';


class Assistant extends StatefulWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {

  final AssistantController assistantController = Get.put(AssistantController());

  @override
  Widget build(BuildContext context){
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                      Text("আমার প্রোফাইল",style: ConstValue.drawerTestStyle,),
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
                      Text("আমার লেখা",style: ConstValue.drawerTestStyle,),
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KajiListPageViewExtend()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("কাজী লিস্ট",style: ConstValue.drawerTestStyle,),
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
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.info,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("সম্পর্কে",style: ConstValue.drawerTestStyle,),
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
        }, icon: const Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('অ্যাসিস্ট্যান্ট'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addAssistant(context);
        },
        backgroundColor: ConstValue.color,
        child: const Icon(Icons.add,size: 32,color: Colors.white,),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        width: screenSize.width,
        height: screenSize.height,
        child: Obx((){
          if (NetworkController.networkError.value &&
              assistantController.assistantList.isEmpty) {
            return Center(
              child: NetworkNotConnect(page: "allPost",controller: assistantController,),
            );
          }
          else if(assistantController.isLoading.value){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(assistantController.assistantList.isNotEmpty){
            return ListView.builder(
                shrinkWrap: true,
                itemCount: assistantController.assistantList.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
                        margin: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      const SizedBox(width: 10,),
                                      Flexible(child: Text("${assistantController.assistantList[index].name}")),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      const SizedBox(width: 10,),
                                      Flexible(
                                          child: GestureDetector(
                                              onLongPress: ()async{
                                                await FlutterPhoneDirectCaller.callNumber("01723434285");
                                              },
                                              child: Text("${assistantController.assistantList[index].phone}")
                                          )
                                      ),
                                    ],
                                  )


                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                                onPressed: (){
                                  deleteAssistant(context,assistantController.assistantList[index].id);
                                },
                                style: OutlinedButton.styleFrom(
                                    primary: ConstValue.whileColor,
                                    backgroundColor: ConstValue.focusColor
                                ),
                                child: const Text('Delete',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            )
                          ],
                        ),
                      )
                  );
                });
          }
          else{
            return EmptyListData(page: "assistantList", controller: assistantController);
          }

        })
      ),
    );
  }

  void deleteAssistant(BuildContext context, int? id)
  {
    var screenSize = MediaQuery.of(context).size;
    Get.defaultDialog(
        title: "Do you want to remove this assistant?",
        titleStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
        content: Container(
          width: screenSize.width * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
          margin: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: (){Navigator.pop(context);},
                  child: const Text("No",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                style: OutlinedButton.styleFrom(
                  backgroundColor: ConstValue.buttonBgDark,
                  primary: ConstValue.whileColor,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: ConstValue.focusColor,
                    primary: ConstValue.whileColor,
                  ),
                  onPressed: (){
                    assistantController.deleteAssistant(id??0);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),)
              ),
            ],
          ),
        )
    );
  }

  void addAssistant(BuildContext context)
  {
    final formState = GlobalKey<FormState>();
    var screenSize = MediaQuery.of(context).size;
    String? name;
    String? phone;
    Get.defaultDialog(
      title: "Add New Assistant",
      content: Container(
        width: screenSize.width * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
        child: SingleChildScrollView(
          child: Form(
            key: formState,
            child: Column(
              children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Name',
                      labelText: 'Name *',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@')) ? 'Please enter valid name' : null;
                    },
                    onSaved: (String? value){
                      name = value;
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone_android_rounded),
                      hintText: "Mobile Number",
                      labelText: 'Mobile Number *',
                      focusColor: ConstValue.focusColor,
                    ),
                    validator: (String? value) {
                      return validateMobile(value!);
                    },
                    onSaved: (String? value){
                      phone = value;
                    },
                  ),
                  const SizedBox(height: 20,),

                 Align(
                   alignment: Alignment.centerRight,
                   child: Obx((){
                     if(assistantController.isAddAssistant.value){
                       return OutlinedButton(
                         style: OutlinedButton.styleFrom(
                             primary: ConstValue.whileColor,
                             backgroundColor: ConstValue.color,
                             side: const BorderSide(width: 0)
                         ),
                         onPressed: () async {
                           if(formState.currentState!.validate()){
                             formState.currentState!.save();
                             bool result = await assistantController.addAssistant({
                               "name" : name,
                               "phone" : phone
                             });
                             formState.currentState!.reset();
                             Navigator.pop(context);
                             if(result){
                               assistantController.isLoading.value = true;
                               assistantController.fetchAssistant();
                             }
                             else{
                               Get.snackbar("Error","Something went to wrong!!",colorText: ConstValue.whileColor,backgroundColor: ConstValue.focusColor);
                             }
                           }
                         },
                         child: const Text("Save"),
                       );
                     }
                     else{
                       return const CircularProgressIndicator(color: ConstValue.color,);
                     }
                   })
                 )
              ],
            ),
          ),
        ),
      )
    );
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11,14}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    else if(isExisted(value)){
      return "Already existed this assistant";
    }
    return null;
  }

  bool isExisted(String value) {
    for(int i=0; i<assistantController.assistantList.length; i++){
      if(assistantController.assistantList[i].phone == value){
        return true;
      }
    }
    return false;
  }
}


