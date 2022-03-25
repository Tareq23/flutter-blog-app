

import 'dart:convert';

import 'package:blog_app/Model/category_model.dart';
import 'package:blog_app/Model/post_model.dart';
import 'package:blog_app/Services/app_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppService{

  static Future<List<PostModel>> fetchAllPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('access_token');
    String accessToken  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA1YmY4ZDdlNjdiOWU1MDQxNzg5NGJhODgzZjdjODU1MThiND"
        "M4NDNjN2E0OWIxMWNhNmU1YTU0YWM0OTQ4NDk2YTM3YzJiNDg2Y2UwNjE5In0.eyJhdWQiOiI1IiwianRpIjoiMDViZjhkN2U2N2I5ZTUwNDE3ODk0"
        "YmE4ODNmN2M4NTUxOGI0Mzg0M2M3YTQ5YjExY2E2ZTVhNTRhYzQ5NDg0OTZhMzdjMmI0ODZjZTA2MTkiLCJpYXQiOjE2NDc5NDc3NzgsIm5iZiI6MTY0"
        "Nzk0Nzc3OCwiZXhwIjoxNjc5NDgzNzc4LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.CJyUUFO9tadZNP93J4LFtJ2ur8dvkEcMshqwoOD-bFUlL__zi"
        "jg2KyjVCYbymg8zIESFrPsGdriKi8V0_upZrTq1epCtPKq-K1MU0Jf3zkGUfVilJG-woQtdCIUQFdmRy_ZLb3a1VafL4qhYzm_1bQJ6yN5qdj9w8IDDE"
        "i0yB365BgXvuXxBTqPYLUpt1djN--YqN0nEsaiRlW_9YpHScHRTtM8CnnwaKFhirSSM0NVqeTvME1QMwXq2VIZdOrewQdtAEk4wtJbvW_kaqL4l44vs9"
        "XePsrPcpwYL-BNKhQrXybNStgGgExkmy05wj1bTyzY5nRoJqQGLTO2xe5C_y7Jbw_ypGwl7uxEyLPoV3mzJUDZDVj0Uf3DqEtCR2xgl2LnWOmS2kJAazom"
        "TExAjtP06bNzBXxEsAdZ9Ef2Euj_u5uQiiJrx848UDgzoiw8jQgV31-CZb0PREoabzSmUFXZHf6qT1hG9gJ5-txAVaMnCapsCAS2nfUuB9KM3szeULWcf-SyJzN"
        "TD7UujPhmAVV8O5mK8ELNia2wwkCXEiqBQKaAJHgG56-jlZ_sf"
        "Swq7aHJAm6ibVaPwHlqfXlJk-9JzsqTqU5Rc8KUEzQtdAoApESy8lzzL4_jWwjAJFJ3nnalpCSgP2fAPK5nzGNqiHJYem4MQ7BSxc8DNdda9-2k";
    var response = await http.post(
              Uri.parse(ApiUrl.BLOG_POST),
              headers: {
                'Content-Type' : 'application/json',
                'Accepts' : 'application/json',
                'Authorization' : 'Bearer $accessToken'
              });
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      var jsonPost = jsonString['data'] as List;
      List<PostModel> _postList = jsonPost.map((items) => PostModel.fromJson(items)).toList();
      return _postList;
    }
    return [];
  }

  static Future<List<PostModel>> fetchUserPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('access_token');
    String accessToken  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA1YmY4ZDdlNjdiOWU1MDQxNzg5NGJhODgzZjdjODU1MThiND"
        "M4NDNjN2E0OWIxMWNhNmU1YTU0YWM0OTQ4NDk2YTM3YzJiNDg2Y2UwNjE5In0.eyJhdWQiOiI1IiwianRpIjoiMDViZjhkN2U2N2I5ZTUwNDE3ODk0"
        "YmE4ODNmN2M4NTUxOGI0Mzg0M2M3YTQ5YjExY2E2ZTVhNTRhYzQ5NDg0OTZhMzdjMmI0ODZjZTA2MTkiLCJpYXQiOjE2NDc5NDc3NzgsIm5iZiI6MTY0"
        "Nzk0Nzc3OCwiZXhwIjoxNjc5NDgzNzc4LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.CJyUUFO9tadZNP93J4LFtJ2ur8dvkEcMshqwoOD-bFUlL__zi"
        "jg2KyjVCYbymg8zIESFrPsGdriKi8V0_upZrTq1epCtPKq-K1MU0Jf3zkGUfVilJG-woQtdCIUQFdmRy_ZLb3a1VafL4qhYzm_1bQJ6yN5qdj9w8IDDE"
        "i0yB365BgXvuXxBTqPYLUpt1djN--YqN0nEsaiRlW_9YpHScHRTtM8CnnwaKFhirSSM0NVqeTvME1QMwXq2VIZdOrewQdtAEk4wtJbvW_kaqL4l44vs9"
        "XePsrPcpwYL-BNKhQrXybNStgGgExkmy05wj1bTyzY5nRoJqQGLTO2xe5C_y7Jbw_ypGwl7uxEyLPoV3mzJUDZDVj0Uf3DqEtCR2xgl2LnWOmS2kJAazom"
        "TExAjtP06bNzBXxEsAdZ9Ef2Euj_u5uQiiJrx848UDgzoiw8jQgV31-CZb0PREoabzSmUFXZHf6qT1hG9gJ5-txAVaMnCapsCAS2nfUuB9KM3szeULWcf-SyJzN"
        "TD7UujPhmAVV8O5mK8ELNia2wwkCXEiqBQKaAJHgG56-jlZ_sf"
        "Swq7aHJAm6ibVaPwHlqfXlJk-9JzsqTqU5Rc8KUEzQtdAoApESy8lzzL4_jWwjAJFJ3nnalpCSgP2fAPK5nzGNqiHJYem4MQ7BSxc8DNdda9-2k";
    var response = await http.get(
              Uri.parse(ApiUrl.USER_BLOG_POST),
              headers: {
                'Content-Type' : 'application/json',
                'Accepts' : 'application/json',
                'Authorization' : 'Bearer $accessToken'
              });
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body) as List;
      // var jsonPost = jsonString['data'] as List;
      // print(jsonString);
      List<PostModel> _postList = jsonString.map((items) => PostModel.fromJson(items)).toList();
      return _postList;
    }
    return [];
  }

  static Future<bool> updatePost(Map postBody,int postId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('access_token');
    String accessToken  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA1YmY4ZDdlNjdiOWU1MDQxNzg5NGJhODgzZjdjODU1MThiND"
        "M4NDNjN2E0OWIxMWNhNmU1YTU0YWM0OTQ4NDk2YTM3YzJiNDg2Y2UwNjE5In0.eyJhdWQiOiI1IiwianRpIjoiMDViZjhkN2U2N2I5ZTUwNDE3ODk0"
        "YmE4ODNmN2M4NTUxOGI0Mzg0M2M3YTQ5YjExY2E2ZTVhNTRhYzQ5NDg0OTZhMzdjMmI0ODZjZTA2MTkiLCJpYXQiOjE2NDc5NDc3NzgsIm5iZiI6MTY0"
        "Nzk0Nzc3OCwiZXhwIjoxNjc5NDgzNzc4LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.CJyUUFO9tadZNP93J4LFtJ2ur8dvkEcMshqwoOD-bFUlL__zi"
        "jg2KyjVCYbymg8zIESFrPsGdriKi8V0_upZrTq1epCtPKq-K1MU0Jf3zkGUfVilJG-woQtdCIUQFdmRy_ZLb3a1VafL4qhYzm_1bQJ6yN5qdj9w8IDDE"
        "i0yB365BgXvuXxBTqPYLUpt1djN--YqN0nEsaiRlW_9YpHScHRTtM8CnnwaKFhirSSM0NVqeTvME1QMwXq2VIZdOrewQdtAEk4wtJbvW_kaqL4l44vs9"
        "XePsrPcpwYL-BNKhQrXybNStgGgExkmy05wj1bTyzY5nRoJqQGLTO2xe5C_y7Jbw_ypGwl7uxEyLPoV3mzJUDZDVj0Uf3DqEtCR2xgl2LnWOmS2kJAazom"
        "TExAjtP06bNzBXxEsAdZ9Ef2Euj_u5uQiiJrx848UDgzoiw8jQgV31-CZb0PREoabzSmUFXZHf6qT1hG9gJ5-txAVaMnCapsCAS2nfUuB9KM3szeULWcf-SyJzN"
        "TD7UujPhmAVV8O5mK8ELNia2wwkCXEiqBQKaAJHgG56-jlZ_sf"
        "Swq7aHJAm6ibVaPwHlqfXlJk-9JzsqTqU5Rc8KUEzQtdAoApESy8lzzL4_jWwjAJFJ3nnalpCSgP2fAPK5nzGNqiHJYem4MQ7BSxc8DNdda9-2k";


    var response = await http.post(
        Uri.parse(ApiUrl.UPDATE_POST + postId.toString()),
        body: postBody,
        headers: {
          'Accepts' : 'application/json',
          'Authorization' : 'Bearer $accessToken'
        });
    print(response.body);
    if(response.statusCode == 200){
      return true;
    }

    return false;

  }


  static Future<String> createPost(Map postBody) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('access_token');
    String accessToken  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA1YmY4ZDdlNjdiOWU1MDQxNzg5NGJhODgzZjdjODU1MThiND"
        "M4NDNjN2E0OWIxMWNhNmU1YTU0YWM0OTQ4NDk2YTM3YzJiNDg2Y2UwNjE5In0.eyJhdWQiOiI1IiwianRpIjoiMDViZjhkN2U2N2I5ZTUwNDE3ODk0"
        "YmE4ODNmN2M4NTUxOGI0Mzg0M2M3YTQ5YjExY2E2ZTVhNTRhYzQ5NDg0OTZhMzdjMmI0ODZjZTA2MTkiLCJpYXQiOjE2NDc5NDc3NzgsIm5iZiI6MTY0"
        "Nzk0Nzc3OCwiZXhwIjoxNjc5NDgzNzc4LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.CJyUUFO9tadZNP93J4LFtJ2ur8dvkEcMshqwoOD-bFUlL__zi"
        "jg2KyjVCYbymg8zIESFrPsGdriKi8V0_upZrTq1epCtPKq-K1MU0Jf3zkGUfVilJG-woQtdCIUQFdmRy_ZLb3a1VafL4qhYzm_1bQJ6yN5qdj9w8IDDE"
        "i0yB365BgXvuXxBTqPYLUpt1djN--YqN0nEsaiRlW_9YpHScHRTtM8CnnwaKFhirSSM0NVqeTvME1QMwXq2VIZdOrewQdtAEk4wtJbvW_kaqL4l44vs9"
        "XePsrPcpwYL-BNKhQrXybNStgGgExkmy05wj1bTyzY5nRoJqQGLTO2xe5C_y7Jbw_ypGwl7uxEyLPoV3mzJUDZDVj0Uf3DqEtCR2xgl2LnWOmS2kJAazom"
        "TExAjtP06bNzBXxEsAdZ9Ef2Euj_u5uQiiJrx848UDgzoiw8jQgV31-CZb0PREoabzSmUFXZHf6qT1hG9gJ5-txAVaMnCapsCAS2nfUuB9KM3szeULWcf-SyJzN"
        "TD7UujPhmAVV8O5mK8ELNia2wwkCXEiqBQKaAJHgG56-jlZ_sf"
        "Swq7aHJAm6ibVaPwHlqfXlJk-9JzsqTqU5Rc8KUEzQtdAoApESy8lzzL4_jWwjAJFJ3nnalpCSgP2fAPK5nzGNqiHJYem4MQ7BSxc8DNdda9-2k";

    var request = http.MultipartRequest("POST",Uri.parse(ApiUrl.CREATE_POST));
    request.fields['headline'] = postBody['headline'];
    request.fields['content'] = postBody['content'];
    request.fields['status'] = postBody['status'].toString();
    request.fields['jobCategory'] = postBody['job_id'].toString();
    request.fields['type'] = "5";
    // request.files.add(await http.MultipartFile.fromPath("image", postBody['image_path']));
    request.files.add(await http.MultipartFile.fromString("image", postBody['image']));
    request.headers.addAll({
      'Content-Type' : 'multipart/form-data',
      'Authorization' : 'Bearer $accessToken'
    });

    var result = request.send();


    var statusCode = ''.obs;

    await result.then((response){
      statusCode.value = response.statusCode.toString();

    });

    return statusCode.value;

  }


  static Future<List<CategoryModel>> fetchCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    var response = await http.get(
              Uri.parse(ApiUrl.CATEGORY),
              headers: {
                'Content-Type' : 'application/json',
                'Accepts' : 'application/json',
                'Authorization' : 'Bearer $accessToken'
              });
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body) as List;
      List<CategoryModel> _catList = jsonString.map((items) => CategoryModel.pareseJsonData(items)).toList();
      return _catList;
    }
    return [];
  }

}