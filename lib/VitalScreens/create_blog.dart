// import 'dart:convert';
//
// import 'package:blog_app/Model/drop_model.dart';
// import 'package:blog_app/Model/dropdown_model.dart';
// import 'package:blog_app/Services/base_client.dart';
// import 'package:blog_app/VitalScreens/my_blog_list.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart' show rootBundle;
//
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:blog_app/Services/app_api.dart';

// class CreateMyBlogListPageView extends StatelessWidget {
//   const CreateMyBlogListPageView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kaji app',
//       showPerformanceOverlay: false,
//
//       // home: LoginPage (title: 'ovivashiBatayon'),
//       home: CreateMyBlogListPageViewExtend(),
//     );
//   }
// }
//
// class CreateMyBlogListPageViewExtend extends StatefulWidget {
//   get _image => null;
//
//   @override
//   _CreateMyBlogListPageStateConfig createState() => _CreateMyBlogListPageStateConfig();
// }
//
// class _CreateMyBlogListPageStateConfig extends State<CreateMyBlogListPageViewExtend> {
//
//   final _globalscaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   late String headline;
//   late String description;
//   late Future<void> createFuture;
//   String? selectJobValue;
//   String? job;
//
//   late Future<void> DropJobFuture;
//   List<String> jobTitleStrList = List<String>.empty(growable: true);
//   List<String> jobTitleIdList = List<String>.empty(growable: true);
//
//   List<LearningCenterModel> _jobList =
//   List<LearningCenterModel>.empty(growable: true);
//
//
//
//   late String userTkn;
//
//
//   late File _image = File('');
//
//   @override
//   initState() {
//     super.initState();
//     DropJobFuture = GetDropJob();
//   }
//
//   Future getImagefromcamera() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//
//     setState(() {
//       _image = image;
//     });
//
//   }
//
//   Future getImagefromGallery() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       _image = image;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         leading: IconButton( onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => MyBlogListPageView()));
//         }, icon: Icon(Icons.arrow_back_sharp,)),
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text('নতুন ব্লগ তৈরী করুন'),
//       ),
//       resizeToAvoidBottomInset: false,
//       key: _globalscaffoldKey,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           reverse: false,
//           child: Form(
//             key: _formKey,
//             child: Container(
//                 margin: EdgeInsets.all(15),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return ' হেডলাইন প্রয়োজন';
//                           } else {
//                             headline = value;
//                           }
//                         },
//                         style: TextStyle(color: Colors.black),
//                         onChanged: (v) {
//                           //_controller.userExists = "unique".obs;
//                           /*_controller.updateButtonStatus();*/
//                         },
//                         decoration: const InputDecoration(
//                           enabledBorder:
//                           OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 1.0),
//                           ),
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 2.0),
//                           ),
//                           fillColor: Colors.black,
//                           label: Text(
//                             'নাম/টাইটেল/হেডলাইন',
//                           ),
//                           labelStyle:
//                           TextStyle(color: Colors.black),
//                         ),
//
//                       ),
//                       const SizedBox(height: 20,),
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return ' বিবরণ প্রয়োজন';
//                           } else {
//                             description = value;
//                           }
//                         },
//                         style: const TextStyle(color: Colors.black),
//                         onChanged: (v) {
//                           //_controller.userExists = "unique".obs;
//                           /*_controller.updateButtonStatus();*/
//                         },
//                         decoration: const InputDecoration(
//                           enabledBorder:
//                           OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 1.0),
//                           ),
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 2.0),
//                           ),
//                           fillColor: Colors.black,
//                           label: Text(
//                             'বিবরণ',
//                           ),
//                           labelStyle:
//                           TextStyle(color: Colors.black),
//                         ),
//
//                       ),
//
//                       Container(
//                         margin: const EdgeInsets.all(5),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children:[
//                             const Text('বিভাগ: ', style:TextStyle(fontWeight: FontWeight.bold)),
//
//
//                             Container(
//
//                                 child: DropdownBuilderMethod(
//                                     DropJobFuture, job)),
//                           ],
//                         ),
//                       ),
//
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: 200.0,
//                               child: Center(
//                                 child: _image == null
//                                     ? Text("No Image is picked")
//                                     : Image.file(_image),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               FloatingActionButton(
//                                 onPressed: getImagefromcamera,
//                                 tooltip: "Pick Image form gallery",
//                                 child: Icon(Icons.add_a_photo),
//                               ),
//                               FloatingActionButton(
//                                 onPressed: getImagefromGallery,
//                                 tooltip: "Pick Image from camera",
//                                 child: Icon(Icons.photo),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                       FlatButton(
//                         minWidth: 160,
//                         height: 45,
//                         color: Color(0xfffec810),
//                         onPressed: () async {
//
//                           if (_formKey.currentState!
//                               .validate()) {
//                             String error = ( await CallFormsFromCreateBlogAPI(headline, description, _image, job));
//
//                             if (error == "") {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(
//                                 const SnackBar(
//                                     content: Text(
//                                         "সঠিক তথ্য দিন")),
//                               );
//                             }
//                           }
//                         },
//
//                         child: Center(
//                           child: Text(
//                             'সেভ',
//                             style: TextStyle(
//                                 color: Colors.black),
//                           ),
//                         ),
//                       ),
//
//
//                     ],
//                   ),
//                 )
//
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   Future<String> CallFormsFromCreateBlogAPI(String headline, String description, File _image2, String? job) async {
//
// /*
//     List<int> imageBytes = widget._image.readAsBytesSync();
//     print(imageBytes);*/
//
//     String jobId = '';
//
//     for (int i = 0; i < jobTitleStrList.length; i++) {
//       String jobStr = jobTitleStrList[i];
//       if (selectJobValue == jobStr) {
//         jobId = jobTitleIdList[i];
//
//       } else {
//         String jobStr = '';
//       }
//     }
//
//
//     final bytes = File(_image2.path).readAsBytesSync();
//     String base64Image =  "data:image/png;base64,"+base64Encode(bytes);
//
//     print("img_pan : $base64Image");
//
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userTkn = (prefs.getString('user_tkn') ?? '');
//     String url = app_api.MRDC_API + 'api/post';
//
//     Map body = {
//       "content": description,
//       "headline": headline,
//       "image":base64Image,
//       "jobCategory":jobId,
//       "type":"5",
//       "status":"1",
//     };
//
//
//
//     var response = await BaseClient().PostMethodWithHeader(url, userTkn, body);
//
//
//
//     return response;
//
//   }
//
//
//
//   Future<List<LearningCenterModel>> GetDropJob() async {
//     List jsonResponse = [];
//     String url = app_api.MRDC_API + 'api/get-desired-job';
//
//     String error = "";
//
//     var dropJobResp = await BaseClient().GetMethod(url);
//
//     try {
//       if (dropJobResp != null) {
//         jsonResponse = json.decode(dropJobResp);
//
//         _jobList = jsonResponse
//             .map((job) => LearningCenterModel.fromJson(job))
//             .toList();
//         String test = '';
//       } else {
//         print(error);
//       }
//     } on Exception {
//       print(error);
//     }
//
//     try {
//       for (int i = 0; i < _jobList.length; i++) {
//         String jobTtlStr = _jobList[i].name;
//         String jobIdStr = (_jobList[i].id).toString();
//
//         jobTitleStrList.add(jobTtlStr);
//         jobTitleIdList.add(jobIdStr);
//       }
//     } catch (Exception) {}
//
//     return _jobList;
//   }
//
//   Widget DropdownBuilderMethod(Future<void> dropJobFuture, value) {
//     return FutureBuilder<void>(
//       future: dropJobFuture,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         debugPrint('Builder');
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             if (snapshot.hasError)
//               return new Text('Loading...');
//             else {
//               if (snapshot.hasData) {
//                 return Padding(
//                   padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                   child: ListTile(
//                     title: const Text(''),
//                     trailing: new DropdownButton<String>(
//                         hint: Text('ক্যাটাগরি'),
//                         onChanged: (newVal) {
//                           selectJobValue = newVal;
//                           setState(() {
//                             job = selectJobValue;
//                             //print(selectJobValue);
//                           });
//                         },
//                         value: selectJobValue,
//                         items: jobTitleStrList.map((String value) {
//                           return new DropdownMenuItem<String>(
//                             value: value,
//                             child: new Text(value),
//                           );
//                         }).toList()),
//                   ),
//                 );
//               } else
//                 return Center(child: CircularProgressIndicator());
//             }
//             break;
//
//           default:
//             debugPrint("Snapshot " + snapshot.toString());
//             return new Text('Loading...');
//         }
//       },
//     );
//   }
//
// }
