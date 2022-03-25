import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
class BaseClient{
  //GET
  static const TIME_OUT = 30;

  get httpClient => null;

  Future<dynamic> PostMethod(String api, Map body) async {
    var url = Uri.parse(api);

    Map bodyMap = body;
    try {
      var response = await http
          .post(url, body: bodyMap)
          .timeout(Duration(seconds: TIME_OUT));
      // print(response);
      return _processResponse(response);
    } on SocketException {
      // print('No Internet connection');
    } on TimeoutException {
      print('Api not responding');
    } catch (e) {
      // print('Unknown error ' + e.toString());
    }
  }

  Future<dynamic> GetMethod(String baseUrl) async {
    var url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);

      return _processResponse(response);
    } on SocketException {
      // print('No Internet connection');
    } on TimeoutException {
      // print('Api not responding');
    } catch (e) {
      // print('Unknown error ' + e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      var responseJson = utf8.decode(response.bodyBytes);

      //var responseJson =response.body;
      // print(responseJson);
      return responseJson;
    } else if (response.statusCode == 201) {
      var responseJson = utf8.decode(response.bodyBytes);
      // print(responseJson);
      return responseJson;
    }
    /*
    else if (response.statusCode == 400) {
      var responseJson = utf8.decode(response.bodyBytes);
      print(responseJson);
      return responseJson;
    }*/
    else {
      return null;
    }
  }



  Future<dynamic> PostMethodWithHeader(String api,String headerStr, Map body) async {
    var url = Uri.parse(api);

    final headers = {HttpHeaders.authorizationHeader: 'Bearer ' + headerStr};

    Map bodyMap = body;
    try {
      var response = await http
          .post(url, headers: headers, body: bodyMap)
          .timeout(Duration(seconds: TIME_OUT));
      // print(response);
      return _processResponse(response);
    } on SocketException {
      // print('No Internet connection');
    } on TimeoutException {
      // print('Api not responding');
    } catch (e) {
      // print('Unknown error ' + e.toString());
    }
  }




  Future<dynamic> GetMethodWithHeader(String api,String headerStr) async {
    var url = Uri.parse(api);

    final headers = {HttpHeaders.authorizationHeader: 'Bearer ' + headerStr};

    try {
      var response = await http
          .get(url, headers: headers,)
          .timeout(Duration(seconds: TIME_OUT));
      // print(response);
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException {
      print('Api not responding');
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

}
