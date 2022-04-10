import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blog_app/ProfileScreens/profile_update.dart';
import 'package:blog_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePageView extends StatelessWidget {

  ProfilePageView({Key? key}) : super(key: key);

  final hintStyle = const TextStyle(color: Color(0xFF555555),fontSize: 14,fontWeight: FontWeight.w400,);
  final textStyle = const TextStyle(color: Color(0xFF0C0606), fontSize: 16, fontWeight: FontWeight.w400,letterSpacing: 1.2,wordSpacing: 1.6);

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF1F1F1),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileUpdatePage()));
        },
        child: const Icon(Icons.edit,color: Color(0xFF000B21),size: 40,),
      ),
      body: SafeArea(
        child: Obx((){
          if(_profileController.profile.value.id != null){

            List<String> splitImage = _profileController.profile.value.image.toString().split(', ');
            // print(splitImage[1]);
            // var profileAvater = File('profileAvater.png');
            Uint8List? base64Image;
            // Uint8List base64Image = base64Decode(splitImage[1]);
            // profileAvater.writeAsBytesSync(splitImage[1].toString());

            return Stack(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.3,
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xFF2588CD),
                          Color(0xFF6CB2F1),
                          Color(0xFF5E7692),
                        ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, left: 5),
                          padding: const EdgeInsets.all(0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFFFFFFFF),
                              size: 24,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            padding: const EdgeInsets.all(0),
                            child: _profileController.profile.value.name.toString() == "null" ? const Text(' ') : Text(
                              _profileController.profile.value.name.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFF9F9),letterSpacing: 1.3,wordSpacing: 1.5),
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            padding: const EdgeInsets.all(0),
                            child: _profileController.profile.value.email.toString() == "null" ? const Text(' ') :Text(
                              _profileController.profile.value.email.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFEAEAEA)),
                            )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: screenSize.height * 0.08,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular((screenSize.width * 0.45)/2),
                    child: Image.asset(
                            'assets/default_person.jpg',
                            width: screenSize.width * 0.45,
                            height: screenSize.width * 0.45,
                            fit: BoxFit.cover,)

                    //_profileController.profile.value.image == "check"
                    //     ? Image.network(
                    //     _profileController.profile.value.image.toString(),
                    //   width: screenSize.width * 0.45,
                    //   height: screenSize.width * 0.45,
                    //   fit: BoxFit.cover,
                    // )
                    //     ? Image.memory(base64Decode(base64String[0]+base64String[1]),
                    //     ? Image.memory(base64Decode(base64String[0]+','+base64String[1]),
                    //     ? Image.memory(base64Image!,
                    //   width: screenSize.width * 0.45,
                    //   height: screenSize.width * 0.45,
                    //   fit: BoxFit.cover,
                    // )
                    //     : Image.asset(
                    //   'assets/default_person.jpg',
                    //   width: screenSize.width * 0.45,
                    //   height: screenSize.width * 0.45,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.35,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    margin: const EdgeInsets.all(0),
                    width: screenSize.width,
                    height: screenSize.height * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.05,
                          ),
                          /* user phone number*/
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: const Icon(
                                    Icons.phone_android_rounded,
                                    color: Color(0xFF366C6C),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('মোবাইল নাম্বার',style: hintStyle,),
                                      _profileController.profile.value.phone.toString() == "null" ? const Text(" ") :
                                      Text(
                                          _profileController.profile.value.phone.toString(),
                                          style: textStyle
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: const Icon(
                                    Icons.home_outlined,
                                    color: Color(0xFF366C6C),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ঠিকানা',style:hintStyle ,),
                                      _profileController.profile.value.address.toString() == "null" ? const Text(" ") :
                                      Text( _profileController.profile.value.address.toString(),
                                          style: textStyle
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Color(0xFF366C6C),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('আমার সম্পর্কে',style:hintStyle ,),
                                      _profileController.profile.value.about.toString() == "null" ? const Text(" ") :
                                      Text(
                                          _profileController.profile.value.about.toString(),
                                          style: textStyle
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          else{
            return Container();
          }
        }),
      ),
    );
  }
}
