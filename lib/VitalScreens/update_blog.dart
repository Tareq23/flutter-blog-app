
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:get/get.dart';

class UpdateMyBlogListPageView extends StatelessWidget {

  var _postController = Get.put(PostController());

  final _htmlEditorController = HtmlEditorController();

  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _focusEditor = false.obs;

  String? headline;
  String? content;
  String? id;

  late String newheadline;




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        leading: IconButton( onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_sharp,)),

        title: const Text('ব্লগ আপডেট করুন'),
      ),
      resizeToAvoidBottomInset: false,
      key: _globalscaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Obx((){
            _postController.updatePost.value = _postController.postDetails.value;
            id = _postController.updatePost.value.id.toString();
            return  Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      children: [
                        TextFormField(
                          minLines: 2,
                          maxLines: null,
                          initialValue:_postController.updatePost.value.headline.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'হেডলাইন প্রয়োজন';
                            } else {
                              newheadline = value;
                            }
                          },
                          style: TextStyle(color: Colors.black),
                          onChanged: (v) {
                            _postController.updatePost.value.headline = v;
                          },
                          decoration: const InputDecoration(
                            enabledBorder:
                             OutlineInputBorder(
                              borderSide:  BorderSide(
                                  color: Colors.black,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black,
                            label:  Text(
                              'নাম/টাইটেল/হেডলাইন',
                            ),
                            labelStyle:
                            TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.only(left: 3),
                          alignment: Alignment.centerLeft,
                          child: const Text('Description',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 20),),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: size.height,
                          ),
                          child: HtmlEditor(
                              controller: _htmlEditorController,
                              htmlToolbarOptions: const HtmlToolbarOptions(
                                toolbarPosition: ToolbarPosition.aboveEditor,
                                toolbarType: ToolbarType.nativeGrid,
                              ),
                              htmlEditorOptions: HtmlEditorOptions(
                                hint: 'Post Description',
                                initialText:  _postController.updatePost.value.content,
                                adjustHeightForKeyboard: false,
                                autoAdjustHeight: true,
                              ),
                              otherOptions: OtherOptions(
                                height: size.height * 0.8,
                              ),
                              callbacks: Callbacks(
                                onChangeContent: (String? changed) {
                                  _postController.updatePost.value.content = changed;
                                },
                                  onFocus:(){
                                    _focusEditor.value = true;
                                  }
                              )
                          ),
                        ),

                        SizedBox(height: 20,),

                        MaterialButton(
                          minWidth: 160,
                          height: 45,
                          color: Color(0xfffec810),
                          onPressed: () async {

                            if (_formKey.currentState!
                                .validate()) {

                              if(_postController.updatePost.value.headline == null || _postController.updatePost.value.content == null){
                                _postController.showErrorSnackbar("সঠিক তথ্য দিন");
                              }

                              _postController.postUpdate();

                              if(_postController.postUpdateResult.value){
                                _postController.postUpdateResult.value = false;
                                _postController.showSuccessSnackbar("কাজটি সম্পন্ন হয়েছে");
                                _postController.userPostList();
                                _postController.fetchPosts();

                                 Navigator.pop(context);
                              }
                            }
                          },

                          child:const  Center(
                            child: Text(
                              'আপডেট',
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

              ),
            );
          }),
        ),
      ),
    );
  }
}