import 'dart:convert';

import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/Model/DistrictModel.dart';
import 'package:blog_app/Model/division_model.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:blog_app/Model/union_model.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'landing_page.dart';
// import '../LogRegScreens/login_page.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:get/get.dart';

import '../Model/sub_district_model.dart';
import '../controller/kaji_list_filter_controller.dart';


class KajiListPageViewExtend extends StatefulWidget {
  @override
  _KajiListPageStateConfig createState() => _KajiListPageStateConfig();
}

class _KajiListPageStateConfig extends State<KajiListPageViewExtend> {

  final profileController = Get.put(ProfileController());
  final kajiListFilterController = Get.put(KajiListFilterController());

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();

  List<PublicBlogListModel> _public_blog_list2 =
  List<PublicBlogListModel>.empty(growable: true);


  late Future<void> public_blog_future2;

  @override
  initState() {
    super.initState();

    // public_blog_future2 = CallFormsFromKajiAPI();
  }

  @override
  Widget build(BuildContext context) {
    profileController.fetchKajiList({});
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        elevation: 0,
        leading: IconButton( onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('কাজী লিস্ট'),
      ),
      resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      floatingActionButton: _filterList(context),
      body: SafeArea(

        child: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          width: screenSize.width,
          height: screenSize.height,

          child: RefreshIndicator(

            onRefresh: () async{
              profileController.isLoadKajiList.value = true;
              profileController.kajiListPage.value++;
              profileController.fetchKajiList({
                "division_id" : kajiListFilterController.selectDivision.value.id == 0 ? "" : kajiListFilterController.selectDivision.value.id.toString(),
                "district_id" : kajiListFilterController.selectDistrict.value.id == 0 ? "" : kajiListFilterController.selectDistrict.value.id.toString(),
                "union_id" : kajiListFilterController.selectUnion.value.id == 0 ? "" : kajiListFilterController.selectUnion.value.id.toString(),
                "subdistrict_id" : kajiListFilterController.selectSubDistrict.value.id == 0 ? "" : kajiListFilterController.selectSubDistrict.value.id.toString(),
                "page" : profileController.kajiListPage.value.toString()
              });
            },
            child: Obx((){
              if(profileController.kajiList.isEmpty){
                return const Center(child: CircularProgressIndicator(color: ConstValue.color,),);
              }
              else{
                return ListView.builder(
                  itemCount: profileController.kajiList.length,
                  itemBuilder: (context,index){
                    return Container(
                      // color: Colors.red,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(0),
                                child: const Image(
                                  image: AssetImage('assets/default_person.jpg'),
                                ),
                              )
                          ),
                          const SizedBox(width: 30,),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text("${profileController.kajiList[index].name}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(
                                      0xFF181818)),),
                                  const SizedBox(height: 15,),

                                  Text("${profileController.kajiList[index].address}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(
                                      0xFF181818)),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          )
        ),


      ),
    );
  }

  FloatingActionButton _filterList(BuildContext context)
  {



    Size screenSize = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: (){
        Get.defaultDialog(
          title: "kaji List Filter!",
          content: Obx((){
            return Container(
              width: screenSize.width * 0.8,
              constraints: BoxConstraints(
                minHeight: screenSize.height * 0.4,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(
                      thickness: 2,
                      color: Color(0xFF313131),
                    ),
                    SizedBox(height: 5,),
                    DropdownButton<DivisionModel>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.indigo.shade900,
                        ),
                        hint: const Text('Select Division'),
                        dropdownColor: Colors.white,
                        value: kajiListFilterController.selectDivision.value,
                        onChanged: (newValue) {
                          kajiListFilterController.selectDivision.value = newValue!;
                          kajiListFilterController.fetchDistrict();
                        },
                        items: kajiListFilterController.divisionList.isNotEmpty
                            ? kajiListFilterController.divisionList
                            .map((items) => DropdownMenuItem<DivisionModel>(
                          child: Text(items.divisionNameBng.toString()),
                          value: items,
                        ))
                            .toList()
                            : []),
                    const SizedBox(height: 10,),
                    DropdownButton<DistrictModel>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.indigo.shade900,
                        ),
                        hint: const Text('Select District'),
                        dropdownColor: Colors.white,
                        value: kajiListFilterController.selectDistrict.value,
                        onChanged: (newValue) {
                          kajiListFilterController.selectDistrict.value = newValue!;
                          kajiListFilterController.fetchSubDistrict();
                        },
                        items: kajiListFilterController.districtList.isNotEmpty
                            ? kajiListFilterController.districtList
                            .map((items) => DropdownMenuItem<DistrictModel>(
                          child: Text(items.districtNameBng.toString()),
                          value: items,
                        ))
                            .toList()
                            : []
                    ),
                    const SizedBox(height: 10,),
                    DropdownButton<SubDistrictModel>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.indigo.shade900,
                        ),
                        hint: const Text('Select Upazila'),
                        dropdownColor: Colors.white,
                        value: kajiListFilterController.selectSubDistrict.value,
                        onChanged: (newValue) {
                          kajiListFilterController.selectSubDistrict.value = newValue!;
                          kajiListFilterController.fetchUnion();
                        },
                        items: kajiListFilterController.subDistrictList.isNotEmpty
                            ? kajiListFilterController.subDistrictList
                            .map((items) => DropdownMenuItem<SubDistrictModel>(
                          child: Text(items.upazilaNameBng.toString()),
                          value: items,
                        ))
                            .toList()
                            : []
                    ),
                    const SizedBox(height: 10,),
                    DropdownButton<UnionModel>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.indigo.shade900,
                        ),
                        hint: const Text('Select Upazila'),
                        dropdownColor: Colors.white,
                        value: kajiListFilterController.selectUnion.value,
                        onChanged: (newValue) {
                          kajiListFilterController.selectUnion.value = newValue!;

                        },
                        items: kajiListFilterController.unionList.isNotEmpty
                            ? kajiListFilterController.unionList
                            .map((items) => DropdownMenuItem<UnionModel>(
                          child: Text(items.unionNameBng.toString()),
                          value: items,
                        ))
                            .toList()
                            : []
                    ),

                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: Color(0xFF7F3737),
                                elevation: 0,
                                primary: Color(0xFFAAAAAA)
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')
                        ),
                        const SizedBox(width: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Color(0xFFFEFFFE),
                            elevation: 0,
                            primary: Color(0xFF073202)
                          ),
                            onPressed: (){
                              profileController.kajiListPage.value = 1;
                              profileController.isLoadKajiList.value = true;
                              profileController.isFilter.value = true;
                              profileController.fetchKajiList({
                                "division_id" : kajiListFilterController.selectDivision.value.id == 0 ? "" : kajiListFilterController.selectDivision.value.id.toString(),
                                "district_id" : kajiListFilterController.selectDistrict.value.id == 0 ? "" : kajiListFilterController.selectDistrict.value.id.toString(),
                                "union_id" : kajiListFilterController.selectUnion.value.id == 0 ? "" : kajiListFilterController.selectUnion.value.id.toString(),
                                "subdistrict_id" : kajiListFilterController.selectSubDistrict.value.id == 0 ? "" : kajiListFilterController.selectSubDistrict.value.id.toString()
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Filter')
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })
        );
      },
      child: Icon(Icons.search,size: 28,color: Colors.white,),
    );
  }

  // Widget ListBuilderKajiMethod(Future<void> public_bloglist_model_fut) {
  //   return FutureBuilder<void>(
  //     future: public_bloglist_model_fut,
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       debugPrint('Builder');
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.done:
  //           if (snapshot.hasError)
  //             return Center(child: new Text('Loading...'));
  //           else {
  //             if (snapshot.hasData) {
  //               if(_public_blog_list2.length>0){
  //                 return ListView.builder(
  //                   itemBuilder: (BuildContext context, int index) {
  //                     String phone = snapshot.data[index].phone;
  //
  //                     String imagefile_nameString = snapshot.data[index].image;
  //
  //                     String img;
  //
  //
  //                     if(imagefile_nameString!=null){
  //                       //img = imagefile_nameString;
  //                       img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
  //                     }
  //                     else
  //                     {
  //                       img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
  //                     }
  //
  //
  //                     return Card(
  //                       margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
  //                       elevation: 5,
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                               margin: EdgeInsets.all(15),
  //
  //                               child: Container(
  //                                   height: 200,
  //                                   child: Image.network(img))),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text("01700000000"),
  //
  //
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                   itemCount: snapshot.data.length,
  //                 );
  //               }
  //               else{
  //                 return Center(child: new Text('কোন তথ্য পাওয়া যায় নি', style: new TextStyle(color: Colors.grey, fontSize: 20)));
  //               }
  //
  //             } else
  //               return Center(child: CircularProgressIndicator());
  //           }
  //           break;
  //
  //         default:
  //           debugPrint("Snapshot " + snapshot.toString());
  //           return Center(child: new Text('Loading...'));
  //       }
  //     },
  //   );
  // }
  //
  //
  //
  //
  // Future<List<PublicBlogListModel>> CallFormsFromKajiAPI() async {
  //   String error = "";
  //   String url = ApiUrl.MRDC_API + 'api/frontend/users?role=3&name&address';
  //
  //
  //
  //   Map body = {
  //     "role": "3",
  //     "name": "",
  //     "address": "",
  //   };
  //
  //   var response = await BaseClient().PostMethod(url, body);
  //   //print(response.body);
  //   try {
  //     if (response == null) {
  //     } else {
  //       try {
  //         Map<String, dynamic> map = json.decode(response);
  //         List<dynamic> data = map["data"];
  //
  //         for (int i = 0; i < 2; i++) {
  //           PublicBlogListModel fact = PublicBlogListModel.fromJson(data[i]);
  //
  //           _public_blog_list2.add(fact);
  //         }
  //       } catch (Exception) {
  //         print(Exception);
  //       }
  //     }
  //   } finally {
  //     print('');
  //   }
  //
  //   return _public_blog_list2;
  // }
}