import 'package:blog_app/VitalScreens/blog_post_details.dart';
import 'package:blog_app/Model/public_blog_list_model.dart';
import 'package:blog_app/VitalScreens/create_new_blog_post.dart';
import 'package:blog_app/VitalScreens/update_blog.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyBlogListPageView extends StatelessWidget
{

  var _userPostController = Get.put(PostController());

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton( onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_sharp,)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('আমার ব্লগ'),
      ),
      // resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.only(left: 0,top: 10,right: 0,bottom: 0),
          height: screenSize.height,
          width: screenSize.width,
          // child: ListBuilderMethod(public_blog_future),
          child: Obx((){
            if(_userPostController.userPostList.isNotEmpty){
              int itemLength = _userPostController.userPostList.length;
              return ListView.builder(
                // itemCount: snapshot.data.length,
                itemCount: _userPostController.userPostList.length,
                itemBuilder: (BuildContext context, int index) {

                  String author = _userPostController.userPostList[index].author.toString();
                  String headline = _userPostController.userPostList[index].headline.toString();
                  // String title = "Blog post title for checking ,$headline";
                  String dataTime =  _userPostController.userPostList[index].created_at.toString();
                  String imageFileNameString = _userPostController.userPostList[index].image.toString();

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
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: (index == itemLength-1) ? 100 : 15),
                    width: MediaQuery.of(context).size.width - 10,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            _userPostController.postDetails.value = _userPostController.userPostList[index];
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => BlogPostDetails(heroAnimationTag)));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Hero(
                                  tag: heroAnimationTag,
                                  child: Image(
                                    image: NetworkImage(img),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Author : $author",
                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.blueGrey.shade900),),
                                    Text("Created at : $dataTime",
                                      style : TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.blueGrey.shade900),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SelectableText(
                                    headline,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(onPressed: (){
                                  _userPostController.postDetails.value = _userPostController.userPostList[index];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateMyBlogListPageView()));
                              }, child: const Text('Edit')),
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: (){},
                                child: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  onPrimary: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          })
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewBlogPost()));
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add,color: Colors.white,size: 35,),
      )
    );
  }
}






