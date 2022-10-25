import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../app.dart';

class SpUtil {

  static const String islogin = "islogin";
  static const String phonenum = "phonenum";
  static  const String code = "code";


  static saveLoginState(bool login) {
    Get.find<SharedPreferences>().setBool(islogin, login);
  }


  static void saveString(String k, String v) {
    Get.find<SharedPreferences>().setString(k, v);
  }
  static void saveDouble(String k, double v) {
    Get.find<SharedPreferences>().setDouble(k, v);
  }
  static double getDouble(String k) {
   return Get.find<SharedPreferences>().getDouble(k);
  }

  static String getString(String k) {
    String v =  Get.find<SharedPreferences>().getString(k);
    if(null==v||v.isEmpty){
      return "";
    }
    return v;

  }

}
