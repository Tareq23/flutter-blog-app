import 'package:blog_app/Model/category_model.dart';
import 'package:blog_app/ProfileScreens/profile_page.dart';
import 'package:blog_app/VitalScreens/blog_post_details.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:blog_app/controller/category_controller.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:blog_app/conversation/message_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogListPageView extends StatelessWidget{

  final PostController _postController = Get.put(PostController());
  final CategoryController _categoryController = Get.put(CategoryController());

  final _globalScaffoldKey = GlobalKey<ScaffoldState>();

  int _selectCategoryId = 0;

  var _searchBarActive = false.obs;


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _globalScaffoldKey,
      endDrawer: Drawer(
        child: Container(
          color: Colors.green,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color(0xFFc1c1c1),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Message()));
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
                  onTap: () {},
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
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/mrdclogo.png')),
        title: const Text('National MRDC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearchDialog(context);
        },
        backgroundColor: const Color(0xFF002632),
        child: const Icon(
          Icons.search_rounded,
          color: Color(0xFFFFFFFF),
          size: 34,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 10),
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Obx((){
            if(_postController.allPostList.isNotEmpty){
              return ListView.builder(
                itemCount: _postController.allPostList.length,
                itemBuilder: (BuildContext context, int index) {

                  String title = _postController.allPostList[index].headline.toString();
                  String author = _postController.allPostList[index].author.toString();
                  String dataTime =
                      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

                  String imageFileNameString = _postController.allPostList[index].image.toString();

                  String img ;
                  // ignore: unnecessary_null_comparison
                  if (imageFileNameString != null) {
                    img = imageFileNameString;
                    List imgUrlExplode = img.split("://");
                    if (img.length > 2000 || imgUrlExplode[0] != "https") {
                      img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                    }
                  } else {
                    img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                  }
                  String heroAnimationTag = index.toString();
                  return Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BlogPostDetails(
                          //             author, title, dataTime,heroAnimationTag)));
                          _postController.postDetails.value = _postController.allPostList[index];
                          Navigator.push(context,MaterialPageRoute(builder: (context) => BlogPostDetails(heroAnimationTag)));
                        },
                        child: Row(
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width * 0.35,
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              child: Hero(
                                tag: heroAnimationTag,
                                child: Image(
                                  image: NetworkImage(img.toString()),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                                width:
                                (screenSize.width * 0.65) - 25,
                                height: screenSize.height *
                                    0.2,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0, top: 0, bottom: 0),
                                margin: const EdgeInsets.all(0),
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    /* Post Title */
                                    Scrollbar(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: double.infinity,
                                          height: screenSize.height * 0.18,
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0),
                                          child: Text(
                                            title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    /* Author and Title */
                                    Container(
                                      width: double.infinity,
                                      height: screenSize.height * 0.02,
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              author,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Expanded(
                                            flex:1,
                                            child: Text(
                                              dataTime,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ));
                },
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  /* Pop up for post search */
  void showSearchDialog(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.2,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xff00132f)),
                        focusColor: Color(0xff00132f),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 2, color: Colors.indigo.shade900)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF1F003E),
                        )),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF2C0131),
                          width: 2,
                        ))),
                  ),
                  const SizedBox(height: 20,),
                  Obx((){
                    return DropdownButton<CategoryModel>(
                      borderRadius: BorderRadius.circular(10),
                      icon: Icon(Icons.arrow_circle_down_outlined,color: Colors.indigo.shade900,),
                      hint: const Text('Select Category'),
                      dropdownColor:Colors.white,
                      value:_categoryController.selectCategoryForSearch.value,
                      onChanged: (newValue){
                        _categoryController.selectCategoryForSearch.value = newValue!;
                      },
                      items: _categoryController.catList.map((items) => DropdownMenuItem<CategoryModel>(
                        child: Text(items.name.toString()),
                        value: items,
                      ) ).toList(),
                    );
                  })
                ],
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: OutlinedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',style: TextStyle(color: Color(
                      0xFF001632),fontSize: 14,fontWeight: FontWeight.w500)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: OutlinedButton(
                  onPressed: (){
                    // Navigator.of(context).pop();
                  },
                  child: const Text('Search',style: TextStyle(color: Color(
                      0xFF001632),fontSize: 16,fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          );
        },
    );
  }
}
