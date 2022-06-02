import 'dart:convert';

import 'package:blog_app/Model/category_model.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controller/category_controller.dart';

class CreateNewBlogPost extends StatefulWidget {
  const CreateNewBlogPost({Key? key}) : super(key: key);

  @override
  _CreateNewBlogPostState createState() => _CreateNewBlogPostState();
}

class _CreateNewBlogPostState extends State<CreateNewBlogPost> {
  var postController = Get.put(PostController());
  // var categoryController = Get.put(CategoryController());

  final titleStyle = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey.shade900);

  final HtmlEditorController _htmlEditorController = HtmlEditorController();

  var completeAllFields = false.obs;

  var _isSubmit = false.obs;
  var _focusEditor = false.obs;

  // List<Map> _statusMap = [
  //   {"id": 1, "value": "Active"},
  //   {"id": 2, "value": "InActive"}
  // ];
  //
  // Map activeStatus = {"id": 1, "value": "Active"};

  @override
  Widget build(BuildContext context) {
    // postController.createPost.value.status = activeStatus['id'];
    // postController.createPost.value.job_id = categoryController.catList[0].id;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Create New Post',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                wordSpacing: 2,
                letterSpacing: 1.5),
          ),
          backgroundColor: ConstValue.color,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
        body: Container(
          // padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          // padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: screenSize.width,
          height: screenSize.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post Title
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            width: screenSize.width * 0.08,
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(0),
                                width: screenSize.width * 0.08,
                                height: screenSize.width * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.indigo.shade900,
                                ),
                                child: const Icon(
                                  Icons.title_rounded,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                postController.createPost.value.headline =
                                    value;
                              },
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.indigo.shade900)),
                                focusColor: Colors.indigo.shade900,
                                hintText: "Post Title",
                                labelText: "Enter Post Title",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _errorWidget('Title Required',
                          postController.createPost.value.headline)
                    ],
                  ),
                ),

                // youtube video link
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            width: screenSize.width * 0.08,
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(0),
                                width: screenSize.width * 0.08,
                                height: screenSize.width * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.indigo.shade900,
                                ),
                                child: const Icon(
                                  Icons.ondemand_video_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                postController.createPost.value.videlUrl =
                                    value;
                              },
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.indigo.shade900)),
                                focusColor: Colors.indigo.shade900,
                                hintText: "Video Url",
                                labelText: "Enter Video Url",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // post Category
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.all(0),
                //             margin: const EdgeInsets.all(0),
                //             width: screenSize.width * 0.08,
                //             alignment: Alignment.centerLeft,
                //             child: Container(
                //                 padding: const EdgeInsets.all(0),
                //                 margin: const EdgeInsets.all(0),
                //                 width: screenSize.width * 0.08,
                //                 height: screenSize.width * 0.08,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(50),
                //                   color: Colors.indigo.shade900,
                //                 ),
                //                 child: const Icon(
                //                   Icons.category_outlined,
                //                   color: Colors.white,
                //                 )),
                //           ),
                //           const SizedBox(
                //             width: 30,
                //           ),
                //           Container(
                //             padding: const EdgeInsets.all(0),
                //             margin: const EdgeInsets.all(0),
                //             child: Obx(() {
                //               if (categoryController.catList.isNotEmpty) {
                //                 return DropdownButton<CategoryModel>(
                //                   value: categoryController
                //                       .selectCategoryForSearch.value,
                //                   icon: Icon(
                //                     Icons.arrow_circle_down_outlined,
                //                     color: Colors.indigo.shade900,
                //                   ),
                //                   hint: const Text('Select Category'),
                //                   dropdownColor: Colors.white,
                //                   onChanged: (newValue) {
                //                     categoryController.selectCategoryForSearch
                //                         .value = newValue!;
                //                     postController.createPost.value.job_id =
                //                         categoryController
                //                             .selectCategoryForSearch.value.id;
                //                   },
                //                   items: categoryController.catList
                //                       .map((items) =>
                //                           DropdownMenuItem<CategoryModel>(
                //                             child: Text(items.name.toString()),
                //                             value: items,
                //                           ))
                //                       .toList(),
                //                 );
                //               } else {
                //                 return const Center(
                //                   child: CircularProgressIndicator(),
                //                 );
                //               }
                //             }),
                //           ),
                //         ],
                //       ),
                //       _errorWidget('Category Required',
                //           postController.createPost.value.job_id)
                //     ],
                //   ),
                // ),

                // post image
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: screenSize.width - 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Image",
                          style: TextStyle(
                              color: Colors.indigo.shade900,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 300,
                        child: Obx(() {
                          if (postController.selectImagePath.value == '') {
                            return Image.asset(
                              'assets/default_blog_post_image.jpg',
                              fit: BoxFit.contain,
                            );
                          } else {
                            return Image.file(
                                File(postController.selectImagePath.value),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain);
                          }
                        }),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: (){
                            postController.getImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      _errorWidget(
                          'Image Required', postController.selectImagePath)
                    ],
                  ),
                ),

                //Post Description
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    maxHeight: screenSize.height * 0.82 + 20,
                  ),
                  child: Obx((){
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text('Description',style:TextStyle(
                          color: Colors.indigo.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                        ),
                        HtmlEditor(
                            controller: _htmlEditorController,
                            htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarPosition: ToolbarPosition.aboveEditor,
                              toolbarType: ToolbarType.nativeGrid,
                              // toolbarItemHeight: screenSize.height * 0.05
                            ),
                            htmlEditorOptions: const HtmlEditorOptions(
                              hint: 'Post Description',
                              adjustHeightForKeyboard: false,
                              autoAdjustHeight: true,
                            ),
                            otherOptions: OtherOptions(
                              // height: screenSize.height * 0.8,
                              height: _focusEditor.value ? screenSize.height * 0.8 : 550,
                            ),
                            callbacks: Callbacks(
                                onChangeContent: (String? changed) {
                                  postController.createPost.value.content = changed;
                                },
                                onFocus:(){
                                  _focusEditor.value = true;
                                }
                            )),
                        _errorWidget('Description Required',
                            postController.createPost.value.content)
                      ],
                    );
                  })
                ),

                //status
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.all(0),
                //             margin: const EdgeInsets.all(0),
                //             width: screenSize.width * 0.08,
                //             alignment: Alignment.centerLeft,
                //             child: Container(
                //                 padding: const EdgeInsets.all(0),
                //                 margin: const EdgeInsets.all(0),
                //                 width: screenSize.width * 0.08,
                //                 height: screenSize.width * 0.08,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(50),
                //                   color: Colors.indigo.shade900,
                //                 ),
                //                 child: const Icon(
                //                   Icons.check,
                //                   color: Colors.white,
                //                 )),
                //           ),
                //           const SizedBox(
                //             width: 30,
                //           ),
                //           Expanded(
                //               child: DropdownButton(
                //             icon: Icon(
                //               Icons.arrow_circle_down_outlined,
                //               color: Colors.indigo.shade900,
                //             ),
                //             hint: const Text(
                //                 'select status'), // Not necessary for Option 1
                //             value: activeStatus['id'],
                //             onChanged: (newValue) {
                //               setState(() {
                //                 activeStatus = {
                //                   "id": newValue,
                //                   "value": newValue == 1 ? "Active" : "InActive"
                //                 };
                //               });
                //               postController.createPost.value.status =
                //                   activeStatus['id'];
                //             },
                //             items: _statusMap.map((Map status) {
                //               return DropdownMenuItem(
                //                   value: status['id'],
                //                   child: Text(
                //                     status['value'].toString(),
                //                   ));
                //             }).toList(),
                //           ))
                //         ],
                //       ),
                //       _errorWidget('Status Required',
                //           postController.createPost.value.status)
                //     ],
                //   ),
                // ),

                /*Submit Button*/
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  alignment: Alignment.centerRight,
                  child: Obx(() {
                    if (completeAllFields.value) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo.shade900,
                      ),
                      onPressed: () async {
                        if (postController.checkCreatePostInputField()) {
                          completeAllFields.value = true;
                          await postController.createNewPost();
                          if(postController.createPostStatusCode.value == "201"){
                            print("if condition : ${postController.createPostStatusCode.value}");
                            postController.showSuccessSnackbar("Post Created success");
                            postController.createPostStatusCode.value="";
                            _isSubmit.value = false;
                            Navigator.pop(context);
                          }
                          else{
                            postController.showErrorSnackbar("Failed to create post");
                          }
                        } else {
                          _isSubmit.value = true;
                          postController.showErrorSnackbar(
                              "Please fill up required field");
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ));
  }

  Widget _errorWidget(String errorMessage, var value) {
    return Obx(() {
      if (_isSubmit.value == true && (value == null || value == "")) {
        // _isInputFieldEmpty.value = true;
        return Container(
            child: Text(
          errorMessage,
          style: const TextStyle(color: Color(0xFFF32C2C)),
        ));
      } else {
        return Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
        );
      }
    });
  }
}
