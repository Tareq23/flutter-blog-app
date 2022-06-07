
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController
{

  static var networkError = false.obs;


  var connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  @override
  void onClose(){

    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }


  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
    if( connectionStatus.value == ConnectivityResult.wifi || connectionStatus.value == ConnectivityResult.mobile){
      networkError.value = false;
    }
    else{
      networkError.value = true;
    }
  }

  static void showNetworkConnection()
  {
    Get.snackbar(
      "Network",
      "Check Your Internet Connection ☁",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffef3f3f),
        colorText: const Color(0xFFFFFFFF)
    );
  }

  static void showInternalError(Map map)
  {
    Get.defaultDialog(
       title: "status code : $map['status_code']",
       content: Container(
         height: 400,
         child: SingleChildScrollView(
           child: Flexible(
             child: Text(map['body']),
           ),
         ),
       )
    );
  }
}