import 'package:blog_app/ProfileScreens/profile_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePageView extends StatelessWidget {

  const ProfilePageView({Key? key}) : super(key: key);

  final hintStyle = const TextStyle(color: Color(0xFF555555),fontSize: 14,fontWeight: FontWeight.w400,);
  final textStyle = const TextStyle(color: Color(0xFF0C0606), fontSize: 16, fontWeight: FontWeight.w400,letterSpacing: 1.2,wordSpacing: 1.6);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF1F1F1),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileUpdatePage()));
        },
        child: const Icon(Icons.add,color: Color(0xFF000B21),size: 40,),
      ),
      body: Stack(
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
                      child: const Text(
                        'Admin',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFF9F9),letterSpacing: 1.3,wordSpacing: 1.5),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        'admin@gmail.com',
                        style: TextStyle(
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
            top: screenSize.height * 0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: SizedBox(
                width: screenSize.width * 0.45,
                height: screenSize.width * 0.45,
                child: Image.asset(
                  'assets/default_person.jpg',
                  fit: BoxFit.cover,
                ),
              ),
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
                                Text('Contact number',style: hintStyle,),
                                Text(
                                  '018888888888',
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
                                Text('Address',style:hintStyle ,),
                                Text(
                                  'In publishing and graphic design, Lorem ipsum is a '
                                      'placeholder text commonly used to demonstrate the visual form '
                                      'of a document or a typeface without relying',
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
                                Text('About',style:hintStyle ,),
                                Text(
                                  'In publishing and graphic design, Lorem ipsum is a '
                                      'placeholder text commonly used to demonstrate the visual form '
                                      'of a document or a typeface without relying',
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
      ),
    );
  }
}
