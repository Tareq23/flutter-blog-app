import 'dart:convert';

import 'package:blinking_text/blinking_text.dart';
import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/Model/DistrictModel.dart';
import 'package:blog_app/Model/city_corporation_model.dart';
import 'package:blog_app/Model/division_model.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:blog_app/Model/union_model.dart';
import 'package:blog_app/ProfileScreens/profile_page.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/VitalScreens/about.dart';
import 'package:blog_app/VitalScreens/assistent.dart';
import 'package:blog_app/VitalScreens/blog_list.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:blog_app/controller/profile_controller.dart';
import 'package:blog_app/controller/unread_message_controller.dart';
import 'package:blog_app/conversation/message_ui.dart';
import 'package:flutter/material.dart';

// import 'landing_page.dart';
// import '../LogRegScreens/login_page.dart';

import 'package:blog_app/Services/base_client.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/sub_district_model.dart';
import '../Services/common_widgets.dart';
import '../controller/kaji_list_filter_controller.dart';
import '../controller/network_controller.dart';

class KajiListPageViewExtend extends StatefulWidget {
  @override
  _KajiListPageStateConfig createState() => _KajiListPageStateConfig();
}

class _KajiListPageStateConfig extends State<KajiListPageViewExtend> {
  late final ProfileController
      profileController; // = Get.put(ProfileController());
  late final KajiListFilterController
      kajiListFilterController; // = Get.put(KajiListFilterController());
  final _globalScaffoldKey = GlobalKey<ScaffoldState>();
  // final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  num unreadMessage = 0;

  // late Future<void> public_blog_future2;

  TextEditingController phoneOrNameController = TextEditingController();

  @override
  void initState() {
    Get.delete<ProfileController>();
    Get.delete<KajiListFilterController>();
    profileController = Get.put(ProfileController());
    kajiListFilterController = Get.put(KajiListFilterController());

    // Get.delete<UnreadMessageController>();
    // unreadMessageController = Get.put(UnreadMessageController());
    UnreadMessageController.fetchUnreadMessageNumber();
    if (UnreadMessageController.unreadMessage['admin'].toString() != "null") {
      setState(() {
        unreadMessage += UnreadMessageController.unreadMessage['admin'];
      });
    }
    if (UnreadMessageController.unreadMessage['user'].toString() != "null") {
      setState(() {
        unreadMessage += UnreadMessageController.unreadMessage['user'];
      });
    }
    super.initState();
    final newVersion = NewVersion(
      androidId: 'com.national24mrdc.BMRP',
    );
    advancedStatusCheck(newVersion);

    phoneOrNameController.addListener(() {
      kajiListFilterController.nameOrPhoneNumber.value =
          phoneOrNameController.text.trim();
    });
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null && status.localVersion != status.storeVersion) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText: 'some new features added!!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    profileController.fetchKajiList({});
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalScaffoldKey,
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
              // const Divider(
              //   color: ConstValue.drawerIconColor
              // ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.dashboard,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ব্লগ",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KajiListPageViewExtend()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.dashboard,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "কাজী লিস্ট",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Assistant()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.dashboard,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "অ্যাসিস্ট্যান্ট",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
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
                      Icon(
                        Icons.person,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "আমার প্রোফাইল",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
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
                      Icon(
                        Icons.dashboard,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "আমার লেখা",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
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
                    children: [
                      Icon(
                        Icons.message,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ম্যাসেজ",
                        style: ConstValue.drawerTestStyle,
                      ),
                      if (unreadMessage != 0)
                        SizedBox(
                          width: 30,
                        ),
                      if (unreadMessage != 0)
                        BlinkText(unreadMessage.toString(),
                            style: TextStyle(
                                fontSize: 32.0, color: Colors.redAccent),
                            beginColor: Color(0xa6ff0000),
                            endColor: Color(0xffff0000),
                            times: 10,
                            duration: Duration(seconds: 1)),
                      if (unreadMessage != 0)
                        SizedBox(
                          width: 30,
                        ),
                      if (unreadMessage != 0)
                        BlinkText(unreadMessage.toString(),
                            style: TextStyle(
                                fontSize: 32.0, color: Colors.redAccent),
                            beginColor: Colors.black,
                            endColor: Color(0xffff0000),
                            times: 10,
                            duration: Duration(seconds: 1)),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.money,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "পেমেন্ট",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "সম্পর্কে",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final removeAccessToken =
                        await prefs.remove('access_token');
                    final removeUserId = await prefs.remove('user_id');
                    if (removeAccessToken || removeUserId) {
                      Get.to(() => const Login());
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.money,
                        color: ConstValue.drawerIconColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: ConstValue.drawerTestStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: ConstValue.drawerIconColor),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        leading: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(0),
            child: Image.asset('assets/bmrplogo2.png')),
        // title: const Text('National MRDC',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        actions: [
          Container(
              margin: const EdgeInsets.all(0),
              // padding: const EdgeInsets.all(0),
              padding: const EdgeInsets.only(top: 18),
              width: screenSize.width * 0.7,
              height: double.infinity,
              child: Center(
                child: Marquee(
                  text:
                      'বাংলাদেশ ম্যারেজ রেজিষ্ট্রার্স প্লাটফর্মে আপনাকে স্বাগতম। ',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              )),
          IconButton(
              onPressed: () {
                _globalScaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.menu_rounded)),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  width: screenSize.width,
                  height: screenSize.height,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      profileController.isLoadKajiList.value = true;
                      profileController.kajiListPage.value++;
                      profileController.fetchKajiList({
                        "division_id": kajiListFilterController
                                    .selectDivision.value.id ==
                                0
                            ? ""
                            : kajiListFilterController.selectDivision.value.id
                                .toString(),
                        "district_id": kajiListFilterController
                                    .selectDistrict.value.id ==
                                0
                            ? ""
                            : kajiListFilterController.selectDistrict.value.id
                                .toString(),
                        "union_id":
                            kajiListFilterController.selectUnion.value.id == 0
                                ? ""
                                : kajiListFilterController.selectUnion.value.id
                                    .toString(),
                        "subdistrict_id": kajiListFilterController
                                    .selectSubDistrict.value.id ==
                                0
                            ? ""
                            : kajiListFilterController
                                .selectSubDistrict.value.id
                                .toString(),
                        "page": profileController.kajiListPage.value.toString()
                      });
                    },
                    child: Obx(() {
                      if (NetworkController.networkError.value &&
                          profileController.kajiList.isEmpty) {
                        return Center(
                          child: NetworkNotConnect(
                            page: "kajiList",
                            controller: profileController,
                            filterController: kajiListFilterController,
                          ),
                        );
                      } else if (profileController.isLoadKajiList.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (profileController.kajiList.isNotEmpty) {
                        return ListView(
                          children: showKajiItem(context),
                        );
                      } else {
                        return EmptyListData(
                          page: "kajiList",
                          controller: profileController,
                        );
                      }
                    }),
                  )),
              Positioned(
                right: 15,
                bottom: 10,
                child: Card(
                  elevation: 40,
                  color: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ConstValue.color,
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: IconButton(
                      onPressed: () {
                        kajiListFilterController.isFilterDialogOpen.value =
                            true;
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (kajiListFilterController.isFilterDialogOpen.value)
                AnimatedPositioned(
                  top: 0,
                  left: 10,
                  right: 10,
                  duration: const Duration(milliseconds: 500),
                  child: _filterKajiList(context),
                )
            ],
          );
        }),
      ),
    );
  }

  List<Widget> showKajiItem(BuildContext context) {
    List<Widget> _list = [];
    for (int index = 0; index < profileController.kajiList.length; index++) {
      _list.add(Container(
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
                )),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profileController.kajiList[index].name}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF181818)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (profileController.kajiList[index].phone != null)
                      Text(
                        "মোবাইল - ${profileController.kajiList[index].phone ?? ''}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF181818)),
                      ),
                    if (profileController
                            .kajiList[index].district?.districtNameBng !=
                        null)
                      Text(
                        "জেলা - ${profileController.kajiList[index].district?.districtNameBng ?? ''}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF181818)),
                      ),
                    if (profileController
                            .kajiList[index].subDistrict?.upazilaNameBng !=
                        null)
                      Text(
                        "উপজেলা - ${profileController.kajiList[index].subDistrict?.upazilaNameBng ?? ''}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF181818)),
                      ),
                    if (profileController.kajiList[index].union?.unionNameBng !=
                        null)
                      Text(
                        "ইউনিয়ন - ${profileController.kajiList[index].union?.unionNameBng ?? ''}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF171616)),
                      ),
                    // Text("সিটি কর্পোরেশন - ${profileController.kajiList[index].union?.unionNameBng??''}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(
                    //     0xFF171616)),),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    }
    _list.add(
      SizedBox(
        height: 15,
      ),
    );
    _list.add(OutlinedButton(
      onPressed: () {
        profileController.isLoadKajiList.value = true;
        profileController.kajiListPage.value++;
        profileController.fetchKajiList({
          "division_id": kajiListFilterController.selectDivision.value.id == 0
              ? ""
              : kajiListFilterController.selectDivision.value.id.toString(),
          "district_id": kajiListFilterController.selectDistrict.value.id == 0
              ? ""
              : kajiListFilterController.selectDistrict.value.id.toString(),
          "union_id": kajiListFilterController.selectUnion.value.id == 0
              ? ""
              : kajiListFilterController.selectUnion.value.id.toString(),
          "subdistrict_id":
              kajiListFilterController.selectSubDistrict.value.id == 0
                  ? ""
                  : kajiListFilterController.selectSubDistrict.value.id
                      .toString(),
          "page": profileController.kajiListPage.value.toString()
        });
      },
      child: const Text(
        'Load more',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        primary: ConstValue.whileColor,
        backgroundColor: ConstValue.color,
      ),
    ));
    return _list;
  }

  Widget _filterKajiList(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 30,
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenSize.height * 0.85,
          minWidth: screenSize.width - 20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffeaeaea),),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'আপনার প্রয়োজন ও পছন্দ অনুযায়ী কাজী খুঁজুন',
                  style: TextStyle(
                      color: Color(0xff313131),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const Divider(
                  thickness: 2,
                  color: Color(0xFF313131),
                ),
                const SizedBox(
                  height: 50,
                ),

                // division filter
                DropdownButton<DivisionModel>(
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(
                      Icons.arrow_circle_down_outlined,
                      color: Colors.indigo.shade900,
                    ),
                    hint: const Text('Select Division'),
                    dropdownColor: Colors.white,
                    autofocus: true,
                    value: kajiListFilterController.selectDivision.value,
                    onChanged: (newValue) {
                      kajiListFilterController.selectDivision.value =
                          newValue!;
                      kajiListFilterController.selectDistrict.value =
                          DistrictModel(
                              0, "Select District", "Select District");
                      kajiListFilterController.selectSubDistrict.value =
                          SubDistrictModel(
                              0, "Select upazila", "Select upazila");
                      kajiListFilterController.selectUnion.value =
                          UnionModel(0, "Select Union", "Select Union");
                      kajiListFilterController.districtList.clear();
                      kajiListFilterController.subDistrictList.clear();
                      kajiListFilterController.unionList.clear();
                      kajiListFilterController.selectCityCorporation.value =
                          CityCorporationModel(
                              0, "Select City", "Select City");
                      kajiListFilterController.cityCorporationList.clear();
                      kajiListFilterController.fetchDistrict();
                    },
                    items: kajiListFilterController.divisionList.isNotEmpty
                        ? kajiListFilterController.divisionList
                            .map((items) => DropdownMenuItem<DivisionModel>(
                                  child:
                                      Text(items.divisionNameBng.toString()),
                                  value: items,
                                ))
                            .toList()
                        : []),
                const SizedBox(
                  height: 20,
                ),

                // district filter
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
                      kajiListFilterController.selectDistrict.value =
                          newValue!;
                      kajiListFilterController.selectSubDistrict.value =
                          SubDistrictModel(
                              0, "Select upazila", "Select upazila");
                      kajiListFilterController.selectUnion.value =
                          UnionModel(0, "Select Union", "Select Union");
                      kajiListFilterController.subDistrictList.clear();
                      kajiListFilterController.unionList.clear();
                      kajiListFilterController.selectCityCorporation.value =
                          CityCorporationModel(
                              0, "Select City", "Select City");
                      kajiListFilterController.cityCorporationList.clear();
                      kajiListFilterController.fetchCity();
                      kajiListFilterController.fetchSubDistrict();
                    },
                    items: kajiListFilterController.districtList.isNotEmpty
                        ? kajiListFilterController.districtList
                            .map((items) => DropdownMenuItem<DistrictModel>(
                                  child:
                                      Text(items.districtNameBng.toString()),
                                  value: items,
                                ))
                            .toList()
                        : []),
                const SizedBox(
                  height: 20,
                ),

                // City corporation filter
                if (kajiListFilterController.cityCorporationList.length > 1)
                  DropdownButton<CityCorporationModel>(
                      borderRadius: BorderRadius.circular(10),
                      icon: Icon(
                        Icons.arrow_circle_down_outlined,
                        color: Colors.indigo.shade900,
                      ),
                      hint: const Text('Select City'),
                      dropdownColor: Colors.white,
                      value: kajiListFilterController
                          .selectCityCorporation.value,
                      onChanged: (newValue) {
                        kajiListFilterController.selectCityCorporation.value =
                            newValue!;
                        kajiListFilterController.selectSubDistrict.value =
                            SubDistrictModel(
                                0, "Select upazila", "Select upazila");
                        kajiListFilterController.selectUnion.value =
                            UnionModel(0, "Select Union", "Select Union");
                        kajiListFilterController.subDistrictList.clear();
                        kajiListFilterController.unionList.clear();
                        kajiListFilterController.fetchCity();
                        kajiListFilterController.fetchSubDistrict();
                      },
                      items: kajiListFilterController
                              .cityCorporationList.isNotEmpty
                          ? kajiListFilterController.cityCorporationList
                              .map((items) =>
                                  DropdownMenuItem<CityCorporationModel>(
                                    child: Text(items.cityNameBng.toString()),
                                    value: items,
                                  ))
                              .toList()
                          : []),
                if (kajiListFilterController.cityCorporationList.length > 1)
                  const SizedBox(
                    height: 20,
                  ),

                // select Sub district
                if (kajiListFilterController.selectCityCorporation.value.id ==
                    0)
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
                        kajiListFilterController.selectSubDistrict.value =
                            newValue!;
                        kajiListFilterController.selectUnion.value =
                            UnionModel(0, "Select Union", "Select Union");
                        kajiListFilterController.unionList.clear();
                        kajiListFilterController.fetchUnion();
                      },
                      items: kajiListFilterController
                              .subDistrictList.isNotEmpty
                          ? kajiListFilterController.subDistrictList
                              .map((items) =>
                                  DropdownMenuItem<SubDistrictModel>(
                                    child:
                                        Text(items.upazilaNameBng.toString()),
                                    value: items,
                                  ))
                              .toList()
                          : []),
                const SizedBox(
                  height: 20,
                ),

                if (kajiListFilterController.selectCityCorporation.value.id ==
                    0)
                  // select union
                  DropdownButton<UnionModel>(
                      borderRadius: BorderRadius.circular(10),
                      icon: Icon(
                        Icons.arrow_circle_down_outlined,
                        color: Colors.indigo.shade900,
                      ),
                      hint: const Text('Select Union'),
                      dropdownColor: Colors.white,
                      value: kajiListFilterController.selectUnion.value,
                      onChanged: (newValue) {
                        kajiListFilterController.selectUnion.value =
                            newValue!;
                      },
                      items: kajiListFilterController.unionList.isNotEmpty
                          ? kajiListFilterController.unionList
                              .map((items) => DropdownMenuItem<UnionModel>(
                                    child:
                                        Text(items.unionNameBng.toString()),
                                    value: items,
                                  ))
                              .toList()
                          : []),

                const SizedBox(
                  height: 160,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF7F3737),
                            backgroundColor: Color(0xFFAAAAAA),
                            elevation: 0,
                          ),
                          onPressed: () {
                            kajiListFilterController
                                .isFilterDialogOpen.value = false;
                          },
                          child: const Text('বাতিল')),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color(0xFFFEFFFE),
                              elevation: 0,
                              primary: Color(0xFF073202)),
                          onPressed: () {
                            profileController.kajiListPage.value = 1;
                            profileController.isLoadKajiList.value = true;
                            profileController.isFilter.value = true;
                            profileController.fetchKajiList({
                              "search" : kajiListFilterController.nameOrPhoneNumber.value.toString(),
                              "division_id": kajiListFilterController
                                          .selectDivision.value.id ==
                                      0
                                  ? ""
                                  : kajiListFilterController
                                      .selectDivision.value.id
                                      .toString(),
                              "district_id": kajiListFilterController
                                          .selectDistrict.value.id ==
                                      0
                                  ? ""
                                  : kajiListFilterController
                                      .selectDistrict.value.id
                                      .toString(),
                              "union_id": kajiListFilterController
                                          .selectUnion.value.id ==
                                      0
                                  ? ""
                                  : kajiListFilterController
                                      .selectUnion.value.id
                                      .toString(),
                              "subdistrict_id": kajiListFilterController
                                          .selectSubDistrict.value.id ==
                                      0
                                  ? ""
                                  : kajiListFilterController
                                      .selectSubDistrict.value.id
                                      .toString(),
                              "city_corporation_id": kajiListFilterController
                                          .selectCityCorporation.value.id ==
                                      0
                                  ? ""
                                  : kajiListFilterController
                                      .selectCityCorporation.value.id
                                      .toString()
                            });
                            kajiListFilterController
                                .isFilterDialogOpen.value = false;
                          },
                          child: const Text('সার্চ করুন'))
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 0,
              top: MediaQuery.of(context).viewInsets.bottom == 0.0 ? (screenSize.height * 0.85) * 0.62 : (screenSize.height * 0.85) * 0.45,
              // top: 0,
              right: 0,
              child: Container(
                color: const Color(0xffeaeaea),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  controller: phoneOrNameController,
                  // keyboardType: TextInputType.number,
                  style: const TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF323232)),
                  decoration: InputDecoration(
                    hintText: "নাম অথবা মোবাইল নাম্বার",
                    hintStyle: const TextStyle(
                        color: Color(0xFF807E7E),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                      const BorderSide(color: Color(0xFF6C6B6B), width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAAAAAA))),
                    labelText: "নাম/মোবাইল নাম্বার",
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff323232),
                        fontWeight: FontWeight.w500),
                  ),
                  validator: (text) {
                    bool check = true;
                    String number = text.toString();
                    int v_0 = "0".codeUnits.first;
                    int v_9 = "9".codeUnits.first;
                    for (int i = 0; i < number.length; i++) {
                      int val = number[i].codeUnits.first;
                      if (val > v_9 || val < v_0) {
                        return "সঠিক নাম্বার দিন";
                      }
                    }
                    if (text == null || text.isEmpty) {
                      return 'আপনার মোবাইল নাম্বার দিন';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
