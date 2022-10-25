import 'dart:convert';

import 'package:wechat_flutter/config/appdata.dart';
import 'package:wechat_flutter/config/logger_util.dart';

import '../tools/wechat_flutter.dart';

class FileConfig {
  static void loadFileData() async {
    //加载联系人列表
    AppData();
    rootBundle.loadString('assets/data/config.json').then((value) {
      Map map = json.decode(value);
      AppData.licence = map["license"];
      AppData.manager = map["manager"];


      // LoggerUtil.e('init ${AppData.licence}');
      // LoggerUtil.e('init ${AppData.manager}');
    });
  }
}
