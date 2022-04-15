import 'dart:io';

import 'package:blog_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {


  ProfileController _profileController = Get.put(ProfileController());
  final _hintStyle = const TextStyle(color: Color(0xFF1E86E8),fontSize: 14,fontWeight: FontWeight.w400);
  final _textFieldStyle = const TextStyle(color: Color(0xFF030305),fontSize: 14,fontWeight: FontWeight.w400);


  var isUpdateActive = false.obs;



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                margin: const EdgeInsets.all(0),
                height: screenSize.height * 0.08,
                decoration: const  BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFE5E5E5),
                      width: 1.5
                    )
                  )
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back,color: Color(0xFF474747),),
                    ),
                    SizedBox(width: screenSize.width * 0.12,),
                    const Text('Edit Profile',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,letterSpacing: 1.2,wordSpacing: 3),)
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.88,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Obx((){
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Stack(
                          children: [
                            ClipOval(
                              child: _profileController.isFileImage.value && _profileController.selectImagePath.value.length > 12
                                      ? Image.file(File(_profileController.selectImagePath.value),height: 200,width: 200,fit: BoxFit.cover,)
                                      : _profileController.selectImagePath.value == '' ?
                                          Image.asset('assets/default_person.jpg',height: 200,width: 200,fit: BoxFit.cover)
                                          : Image.network(_profileController.selectImagePath.value,height: 200,width: 200,fit: BoxFit.cover),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 20,
                              child: IconButton(
                                onPressed: (){
                                  _profileController.getImage(ImageSource.gallery);
                                },
                                icon: const Icon(Icons.camera_alt,color: Color(0xFFFC4B4B),size: 36,),
                              ),
                            )
                          ],
                        ),

                        /* user name */
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('নাম',style: _hintStyle,),
                              TextFormField(
                                initialValue: _profileController.profile.value.name.toString(),
                                onChanged: (value){
                                  _profileController.profile.value.name = value;
                                },
                                decoration: const InputDecoration(
                                    focusColor: Color(0xff00132f),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1F003E),
                                        )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF2C0131),
                                          width: 2,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),

                        /* user contact number */
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('মোবাইল নাম্বার',style: _hintStyle,),
                              TextFormField(
                                initialValue: _profileController.profile.value.phone,
                                onChanged: (value){
                                  _profileController.profile.value.phone = value;
                                },
                                decoration: const InputDecoration(
                                    focusColor: Color(0xff00132f),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1F003E),
                                        )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF2C0131),
                                          width: 2,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),

                        /* user email */
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ইমেইল',style: _hintStyle,),
                              TextFormField(
                                initialValue: _profileController.profile.value.email,
                                onChanged: (value){
                                  _profileController.profile.value.email = value;
                                },
                                decoration: const InputDecoration(
                                    focusColor: Color(0xff00132f),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1F003E),
                                        )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF2C0131),
                                          width: 2,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),

                        /* user about*/
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('আমার সম্পর্কে',style: _hintStyle,),
                              TextFormField(
                                minLines: 3,
                                maxLines: null,
                                initialValue: _profileController.profile.value.about,
                                onChanged: (value){
                                  _profileController.profile.value.about = value;
                                },
                                decoration: const InputDecoration(
                                    focusColor: Color(0xff00132f),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1F003E),
                                        )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF2C0131),
                                          width: 2,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        /* user address*/
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ঠিকানা',style: _hintStyle,),
                              TextFormField(
                                minLines: 3,
                                maxLines: null,
                                initialValue:  _profileController.profile.value.address,
                                onChanged: (value){
                                  _profileController.profile.value.address = value;
                                },
                                decoration: const InputDecoration(
                                    focusColor: Color(0xff00132f),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1F003E),
                                        )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF2C0131),
                                          width: 2,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        /* update button*/
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xff0063a7),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: isUpdateActive.value == false ?  InkWell(
                              onTap: () async{
                                isUpdateActive.value = true;
                                await _profileController.updateProfile();
                                isUpdateActive.value = false;
                              },
                              child: const Text('পরিবর্তন করুন',style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 26,fontWeight: FontWeight.w500),),
                            ): const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.2,)
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
