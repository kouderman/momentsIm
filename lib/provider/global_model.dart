import 'dart:convert';

import 'package:wechat_flutter/config/appdata.dart';
import 'package:wechat_flutter/im/entity/i_person_info_entity.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/provider/loginc/global_loginc.dart';

import '../config/logger_util.dart';

class GlobalModel extends ChangeNotifier {
  BuildContext context;

  ///app的名字
  String appName = "微信flutter";

  /// 用户信息
  String account = '';
  String nickName = '';
  String count = "1";
  String area = '';
  String sign = '';
  String email = '';
  String avatar = '';
  int gender = 0;

  String sex ="男";
  String birthday ="";

  ///当前语言
  List<String> currentLanguageCode = ["zh", "CN"];
  String currentLanguage = "中文";
  Locale currentLocale;

  ///是否进入登录页
  bool goToLogin = true;

  GlobalLogic logic;


  GlobalModel() {
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait([
        logic.getAppName(),
        logic.getCurrentLanguageCode(),
        logic.getCurrentLanguage(),
        logic.getLoginState(),
        logic.getAccount(),
        // logic.getNickName(),
        // logic.getFaceUrl(),
        // logic.getGender(),
      ]).then((value) {
        currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
        refresh();
      });
    }
  }

  void initInfo() async {
    final data = await getUsersProfile([account]);
    // if (data == null) return;
    // List<dynamic> result = json.decode(data);
    if (Platform.isAndroid) {
      // nickName = result[0]['nickName'];
      // email = AppData.respprofile.data.email;
      // await SharedUtil.instance
      //     .saveString(Keys.nickName, result[0]['nickName']);
      avatar = AppData.respprofile.data.avatar;
      email = AppData.respprofile.data.email;
      sign = AppData.respprofile.data.aboutYou;

      nickName = AppData.respprofile.data.firstName+","+AppData.respprofile.data.lastName;
      sex =AppData.respprofile.data.gender =="F"?"女":"男";
      area = AppData.respprofile.data.country+" " +AppData.respprofile.data.province+" "+AppData.respprofile.data.city;

      // await SharedUtil.instance.saveString(Keys.faceUrl, result[0]['faceUrl']);
      // // gender = result[0]['gender'];
      // await SharedUtil.instance.saveInt(Keys.gender, result[0]['gender']);
    } else {
      avatar = AppData.respprofile.data.avatar;
      email = AppData.respprofile.data.email;
      sign = AppData.respprofile.data.aboutYou;

      nickName = AppData.respprofile.data.firstName+","+AppData.respprofile.data.lastName;
      sex =AppData.respprofile.data.gender =="F"?"女":"男";
      area = AppData.respprofile.data.country+" " +AppData.respprofile.data.province+" "+AppData.respprofile.data.city;
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("GlobalModel销毁了");
  }

  void refresh() {
    if (!goToLogin) initInfo();
    // LoggerUtil.e("全局修改用户信息=======================22222222222222");
    notifyListeners();
  }
}
