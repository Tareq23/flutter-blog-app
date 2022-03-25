import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {


  final _hintStyle = const TextStyle(color: Color(0xFF1E86E8),fontSize: 14,fontWeight: FontWeight.w400);
  final _textFieldStyle = const TextStyle(color: Color(0xFF030305),fontSize: 14,fontWeight: FontWeight.w400);


  bool _isSelectImage = false;
  final _imagePicker = ImagePicker();

  var _image;
  Future cameraImage() async {
    ImagePicker pickedFile = await _imagePicker.getImage(source: ImageSource.camera) as ImagePicker;
    setState(() {
      // _image = File(pickedFile.path);
      // _isSelectImage = true;
    });
    Navigator.pop(context);
  }
  Future _galleryImage() async {
    ImagePicker pickedFile = await _imagePicker.getImage(source: ImageSource.gallery) as ImagePicker;
    setState(() {
      // _image = File(pickedFile.path);
      // _isSelectImage = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
              height: screenSize.height * 0.92,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Image(
                            // image: AssetImage(
                            //   _isSelectImage ? _image.toString() : 'assets/default_person.jpg',
                            // ),
                            image: _isSelectImage == false ? const AssetImage("assets/default_blog_post_image.jpg") : FileImage(_image) as ImageProvider,
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: IconButton(
                            onPressed: (){
                              _galleryImage();
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
                          Text('Name',style: _hintStyle,),
                          TextFormField(
                            initialValue: "Admin's name",
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
                          Text('Contact Number',style: _hintStyle,),
                          TextFormField(
                            initialValue: "01888888888",
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
                          Text('Email',style: _hintStyle,),
                          TextFormField(
                            initialValue: "admin@gmail.com",
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
                          Text('About',style: _hintStyle,),
                          TextFormField(
                            minLines: 3,
                            maxLines: null,
                            initialValue:  'In publishing and graphic design, Lorem ipsum is a '
                                'placeholder text commonly used to demonstrate the visual form '
                                'of a document or a typeface without relying',
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
                          Text('Address',style: _hintStyle,),
                          TextFormField(
                            minLines: 3,
                            maxLines: null,
                            initialValue:  'In publishing and graphic design, Lorem ipsum is a '
                                'placeholder text commonly used to demonstrate the visual form '
                                'of a document or a typeface without relying',
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
                          color: Color(0xff0063a7),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: InkWell(
                          onTap: (){},
                          child: const Text('Update Profile',style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 26,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
