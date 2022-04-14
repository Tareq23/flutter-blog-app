import 'package:blog_app/Services/color.dart';
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

class MyBlogListPageView extends StatefulWidget{
  MyBlogListState createState(){
    return MyBlogListState();
  }
}
class MyBlogListState extends State<MyBlogListPageView>{

  var _userPostController = Get.put(PostController());

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  var isClickedDelete = false.obs;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstValue.color,
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
          // padding: const EdgeInsets.only(left: 0,top: 10,right: 0,bottom: 0),
          padding: const EdgeInsets.all(0),
          height: screenSize.height,
          width: screenSize.width,
          // child: ListBuilderMethod(public_blog_future),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              await _userPostController.fetchUserPosts();
            },
            child: Obx((){
              if(_userPostController.userPostList.isNotEmpty){
                int itemLength = _userPostController.userPostList.length;
                return ListView.builder(
                  // itemCount: snapshot.data.length,
                  itemCount: _userPostController.userPostList.length,
                  itemBuilder: (BuildContext context, int index) {

                    String author = _userPostController.userPostList[index].author.toString();
                    String headline = _userPostController.userPostList[index].headline.toString();

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
                    }
                    else {
                      img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                    }
                    String heroAnimationTag = index.toString();
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: (index == itemLength-1) ? 100 : 15,),
                      padding: EdgeInsets.only(top: (index == 0) ? 15 : 0),
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
                                  onPressed: (){
                                    deletePostDialog(context,_userPostController.userPostList[index].id.toString());
                                  },
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
                _userPostController.userPostList();
                return const Center(child: CircularProgressIndicator(),);
              }
            }),
          )
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


  void deletePostDialog(BuildContext context, String postId)
  {
    showDialog(context: context, builder: (context){
        return AlertDialog(
          elevation: 222,
          backgroundColor: const Color(0xFFACACAC),
          content: Text('Are you sure? $postId',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(
              0xff9e0000)),),
          actions: [
            Obx((){
              if(isClickedDelete.value == false){
                return OutlinedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Color(0xffc2c2c2),
                  ),
                  child: const Text('Canecl',style: TextStyle(color: Colors.black),),
                );
              }
              else{
                return Container();
              }
            }),
            Obx((){
              if(isClickedDelete.value){
                return const CircularProgressIndicator();
              }
              else{
                return OutlinedButton(
                  onPressed: () async{
                    isClickedDelete.value = true;
                    var result =  await _userPostController.deletePost(postId);
                    if( result == true){
                      _userPostController.showSuccessSnackbar("Successfully Deleted!");
                      isClickedDelete.value = false;
                      await _userPostController.fetchUserPosts();
                      Navigator.of(context).pop();
                    }
                    else{
                      _userPostController.showErrorSnackbar("Something's Wrong");
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Color(0xfff32828),
                    backgroundColor: Color(0xfff32828),
                  ),
                  child: const Text('Delete',style: TextStyle(color: Colors.black),),
                );
              }
            }),
          ],
        );
    });
  }

}






