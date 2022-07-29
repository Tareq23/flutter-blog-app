

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blog_app/Model/DistrictModel.dart';
import 'package:blog_app/Model/assistant_model.dart';
import 'package:blog_app/Model/category_model.dart';
import 'package:blog_app/Model/division_model.dart';
import 'package:blog_app/Model/message_model.dart';
import 'package:blog_app/Model/post_model.dart';
import 'package:blog_app/Model/profile_model.dart';
import 'package:blog_app/Model/union_model.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:blog_app/controller/network_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/sub_district_model.dart';

class AppService{


  static const TIME_OUT = 30;


  static Future<List<PostModel>> fetchAllPost(Map<String, dynamic> map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

   try{
     NetworkController.networkError.value = false;
     var response = await http.post(
         Uri.parse(ApiUrl.BLOG_POST),
         headers: {
           'Content-Type' : 'application/x-www-form-urlencoded',
           'Accepts' : 'application/json',
           'Authorization' : 'Bearer $accessToken'
         },
       body: map
     ).timeout(const Duration(seconds: TIME_OUT));
     //print("all post fetch status code : ${response.statusCode}");
     if(response.statusCode == 200){
       var jsonString = jsonDecode(response.body);
       var jsonPost = jsonString['data'] as List;
       // print(response.body);
       List<PostModel> _postList = jsonPost.map((items) => PostModel.fromJson(items)).toList();
       return _postList;
     }
   }
   on SocketException{
     NetworkController.networkError.value = true;
   }
   on TimeoutException{
     NetworkController.networkError.value = true;
   }
   finally{

   }
    return [];
  }

  static Future<Map> fetchUnreadMessageNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

   try{
     var response = await http.get(
         Uri.parse(ApiUrl.UNREAD_MESSAGE_COUNT),
         headers: {
           'Authorization' : 'Bearer $accessToken'
         }).timeout(const Duration(seconds: TIME_OUT));
     if(response.statusCode == 200){
        return jsonDecode(response.body);
     }
   }
   on SocketException{
     NetworkController.networkError.value = true;
   }
   on TimeoutException{
     NetworkController.networkError.value = true;
   }
    return {"admin": 0, "user": 0};
  }

  static Future<List<PostModel>> fetchUserPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.USER_BLOG_POST),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));

      //print(response.body);

      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<PostModel> _postList = jsonString.map((items) => PostModel.fromJson(items)).toList();
        return _postList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    return [];
  }

  static Future<bool> updatePost(Map postBody,int postId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;
      var response = await http.post(
          Uri.parse(ApiUrl.UPDATE_POST + postId.toString()),
          body: postBody,
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode.toString() == "200" || response.statusCode.toString() == "201"){
        return true;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return false;
  }


  static Future<String> createPost(Map postBody) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;

      var request = http.MultipartRequest("POST",Uri.parse(ApiUrl.CREATE_POST));
      request.fields['headline'] = postBody['headline'];
      request.fields['content'] = postBody['content'];
      request.fields['status'] = postBody['status'].toString();
      // request.fields['jobCategory'] = postBody['job_id'].toString();
      request.fields['type'] = "5";
      request.fields['video'] = postBody['video']??"";
      // request.files.add(await http.MultipartFile.fromPath("image", postBody['image_path']));
      request.files.add(await http.MultipartFile.fromString("image", postBody['image']));
      request.headers.addAll({
        'Content-Type' : 'multipart/form-data',
        'Authorization' : 'Bearer $accessToken'
      });

      var result = request.send().timeout(const Duration(seconds: TIME_OUT));

      var statusCode = ''.obs;

      await result.then((response){
        statusCode.value = response.statusCode.toString();
      });
      return statusCode.value;
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }

    return '';

  }


  static Future<List<CategoryModel>> fetchCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;

      var response = await http.get(
          Uri.parse(ApiUrl.CATEGORY),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<CategoryModel> _catList = jsonString.map((items) => CategoryModel.pareseJsonData(items)).toList();
        return _catList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }



  static Future<bool> deletePost(String postId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      var response = await http.get(
          Uri.parse(ApiUrl.DELETE_POST+postId),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));

      if(response.statusCode.toString() == "200" || response.statusCode.toInt() == 200) {
        return true;
      }
    }
    on SocketException{
      NetworkController.showNetworkConnection();
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return false;
  }

  static Future<ProfileModel> fetchUserProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    int userId = prefs.getInt('user_id')?? 0;
    // String userId = "101";
    try{
      var response = await http.get(
          Uri.parse(ApiUrl.USER_PROFILE+userId.toString()),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode.toString() == "200" || response.statusCode.toInt() == 200) {
        //print(response.body);
        var profileData = jsonDecode(response.body);
        // print(response.body);
        ProfileModel _profile = ProfileModel.fromJson(profileData);
        return _profile;
      }
    }
    on SocketException{
      NetworkController.showNetworkConnection();
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return ProfileModel();
  }

  static Future<ProfileModel> updateUserProfile(Map userInfo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    //String userId = "101";
    int userId = prefs.getInt('user_id')?? 0;
    try{
      var request = http.MultipartRequest("POST",Uri.parse(ApiUrl.USER_PROFILE_UPDATE+userId.toString()));
      request.fields['name'] = userInfo['name'];
      request.fields['email'] = userInfo['email'];
      request.fields['phone'] = userInfo['phone'].toString();
      request.fields['about'] = userInfo['about'].toString();
      request.fields['address'] = userInfo['address'].toString();
      if(userInfo['isFileImage']){
        request.files.add(http.MultipartFile.fromString("image", userInfo['image']));
      }
      request.headers.addAll({
        'Content-Type' : 'multipart/form-data',
        'Authorization' : 'Bearer $accessToken'
      });

      var result = await request.send().timeout(const Duration(seconds: TIME_OUT));

      var response = await http.Response.fromStream(result);
      //print(response.body);
      var updatedProfile = ProfileModel().obs;
      updatedProfile.value = ProfileModel.fromJson(jsonDecode(response.body));
      return updatedProfile.value;
    }
    on SocketException{
      NetworkController.showNetworkConnection();
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return ProfileModel();
  }


  static Future<MessageModel> sendMessage(Map message) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;
      var response = await http.post(
          Uri.parse(ApiUrl.USER_MESSAGE_SEND),
          body: message,
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      //print(response.body);
      // print("status code from message ${response.statusCode}");
      //print(message);
      // print(accessToken);
      if(response.statusCode == 200 || response.statusCode == 201){
        var result = jsonDecode(response.body);
        return MessageModel.parseJsonData(result);
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    return MessageModel(0, 0, "name", "messageText", "imgUrl", DateTime.now(), "createdAtAgo");
  }
  static Future<List<MessageModel>> fetchMessage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.USER_MESSAGE_GET),
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode.toString() == "200" || response.statusCode.toString() == "201"){

        var jsonString = jsonDecode(response.body) as List;
        List<MessageModel> replayList,_list=[];
        List<MessageModel> msgList=[];
        msgList = jsonString.map((e) {
          var _msgCheck = e['replay'] as List;
          if(_msgCheck.isNotEmpty){
            replayList = _msgCheck.map((item)=>MessageModel.parseJsonData(item)).toList();
            _list.addAll(replayList);
          }
          //print(e);
          return MessageModel.parseJsonData(e);
        }).toList();
        for(int i=0,j=0; i<msgList.length && j < _list.length; i++){
            if(msgList[i].id == _list[j].parentId){
              msgList.insert(i+1, _list[j++]);
            }
        }
        return msgList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    return [];
  }
  static Future<List<MessageModel>> fetchAdminMessage(Map map) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.ADMIN_MESSAGE_GET+"?skip=${map['skip']}&take${map['take']}"),
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          },
      ).timeout(const Duration(seconds: TIME_OUT));
      // print("Status code Admin Info Message : ${response.statusCode}");
      // print(response.body);
      if(response.statusCode.toString() == "200" || response.statusCode.toString() == "201"){

        var jsonString = jsonDecode(response.body) as List;
        List<MessageModel> replayList,_list=[];
        List<MessageModel> msgList=[];
        msgList = jsonString.map((e) {
          var _msgCheck = e['replay'] as List;
          if(_msgCheck.isNotEmpty){
            replayList = _msgCheck.map((item)=>MessageModel.parseJsonData(item)).toList();
            _list.addAll(replayList);
          }
          //print(e);
          return MessageModel.parseJsonData(e);
        }).toList();
        for(int i=0,j=0; i<msgList.length && j < _list.length; i++){
            if(msgList[i].id == _list[j].parentId){
              msgList.insert(i+1, _list[j++]);
            }
            //print("admin message image Url : ${msgList[i].imgUrl}");
        }
        return msgList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    return [];
  }


  static Future<List<ProfileModel>> fetchKajiProfileList(Map filter) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    try{
      var request = http.MultipartRequest("POST",Uri.parse(ApiUrl.KAJI_PROFILE));
      request.fields['name'] = filter['name'];
      request.fields['division_id'] = filter['division_id'];
      request.fields['district_id'] = filter['district_id'];
      request.fields['sub_district_id'] = filter['sub_district_id'];
      request.fields['address'] = filter['address'];
      request.headers.addAll({
        'Content-Type' : 'multipart/form-data',
        'Authorization' : 'Bearer $accessToken'
      });
      var result = await request.send().timeout(const Duration(seconds: TIME_OUT));
      var response = await http.Response.fromStream(result);
      var jsonString = jsonDecode(response.body) ;
      //jsonString = jsonDecode(jsonString['data']) as List;
      // myList = new List<String>.from(results['users']);
      // results['users'].cast<String>();
      jsonString = jsonString['data'];
      //print(jsonString);
      List _list = jsonString as List;
      List<ProfileModel> _profileList = [];
      for(int i=0; i<_list.length; i++){
        _profileList.add(ProfileModel.fromJson(_list[i]));

      }
      //print(_profileList.length);

      return _profileList;
    }
    on SocketException{
      NetworkController.showNetworkConnection();
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }

    return [];
  }


  static Future<List<ProfileModel>> fetchKajiList(Map filter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    String url = "${ApiUrl.KAJI_CONTACT}division_id=${filter['division_id']}&"
        "district_id=${filter['district_id']}&subdistrict_id=${filter['subdistrict_id']}"
        "&search=${filter['search']}&city_corporation_id=${filter['city_corporation_id']}&union_id=${filter['union_id']}"
        "&ward_union=${filter['ward_union']}&type=${filter['type']}&limit=${filter['limit']}&page=${filter['page']}";

    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      // print("from app service contact list statusCode ${response.statusCode}");
      if(response.statusCode == 200){
        // print(url);
        // print(response.body);
        var jsonString = jsonDecode(response.body);
        //jsonString = jsonDecode(jsonString['data']) as List;
        // myList = new List<String>.from(results['users']);
        // results['users'].cast<String>();
        jsonString = jsonString['data'];
        //print(jsonString);
        List _list = jsonString as List;
        List<ProfileModel> _profileList = [];
        for(int i=0; i<_list.length; i++){
          _profileList.add(ProfileModel.fromJson(_list[i]));

        }
        //print(_profileList.length);

        return _profileList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];

  }

  static Future<List<DivisionModel>> fetchDivision() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;

      var response = await http.get(
          Uri.parse(ApiUrl.DIVISION_LIST),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<DivisionModel> _catList = jsonString.map((items) => DivisionModel.parseJsonData(items)).toList();
        return _catList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }

  static Future<List<DistrictModel>> fetchDistrict(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;

      var response = await http.get(
          Uri.parse(ApiUrl.DISTRICT_LIST+id.toString()),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<DistrictModel> _districtList = jsonString.map((items) => DistrictModel.parseJsonData(items)).toList();
        return _districtList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }

  static Future<List<SubDistrictModel>> fetchSubDistrict(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.SUB_DISTRICT_LIST+id.toString()),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<SubDistrictModel> _subDistrictList = jsonString.map((items) => SubDistrictModel.parseJsonData(items)).toList();
        return _subDistrictList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }

  static Future<List<UnionModel>> fetchUnion(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.UNION_LIST+id.toString()),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<UnionModel> _unionList = jsonString.map((items) => UnionModel.parseJsonData(items)).toList();
        return _unionList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }


  static Future<List<AssistantModel>> fetchAssistant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.ASSISTENT_LIST),
          headers: {
            'Content-Type' : 'application/json',
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));
      // print("fetch assistant status code : ${response.statusCode}");
      // print(response.body);
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body) as List;
        List<AssistantModel> _assistantList = jsonString.map((items) => AssistantModel.parseJsonData(items)).toList();
        return _assistantList;
      }
    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{

    }
    return [];
  }


  static Future<bool> addAssistant(Map assistant) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.post(
          Uri.parse(ApiUrl.ASSISTENT_ADD),
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          },body: assistant).timeout(const Duration(seconds: TIME_OUT));

      // print(response.statusCode);
      // print(response.body);
      if(response.statusCode == 201 || response.statusCode == 200)
        {
          return true;
        }

    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{


    }
    return false;
  }


  static Future<bool> deleteAssistant(int id) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.delete(
          Uri.parse(ApiUrl.ASSISTENT_REMOVE+id.toString()),
          headers: {
            'Accepts' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }).timeout(const Duration(seconds: TIME_OUT));

      // print(response.statusCode);
      // print(response.body);
      if(response.statusCode == 201 || response.statusCode == 200)
      {
        return true;
      }

    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{


    }
    return false;
  }


  static Future<String> fetchAbout() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try{
      NetworkController.networkError.value = false;
      var response = await http.get(
          Uri.parse(ApiUrl.ABOUT)).timeout(const Duration(seconds: TIME_OUT));

      // print("status code : ${response.statusCode}");
      // print(response.body);
      if(response.statusCode == 201 || response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        // print(data);
        // print(data['content']);
        return data['content'];
      }

    }
    on SocketException{
      NetworkController.networkError.value = true;
    }
    on TimeoutException{
      NetworkController.networkError.value = true;
    }
    finally{


    }
    return "";
  }



}