import 'dart:io';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_flutter/config/file_config.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/provider_config.dart';
import 'package:wechat_flutter/app.dart';
import 'package:wechat_flutter/im/all_im.dart';
import 'package:wechat_flutter/tools/data/data.dart';

import 'config/storage_manager.dart';

EventBus eventBus = EventBus();
bool isListener = true;

final RouteObserver<PageRoute> routeObserver = RouteObserver();

void main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  // AMapFlutterLocation.updatePrivacyAgree(true);
  // AMapFlutterLocation.updatePrivacyShow(true, true);
  // AMapFlutterLocation.setApiKey("iOS的Key", "Android的key");


  /// 数据初始化
  await Data.initData();

  await FileConfig.loadFileData();


  /// 配置初始化
  await StorageManager.init();

  await Get.putAsync(() => SharedPreferences.getInstance());

  /// APP入口并配置Provider
  runApp(ProviderConfig.getInstance().getGlobal(MyApp()));

  /// 自定义报错页面
  // ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
  //   debugPrint(flutterErrorDetails.toString());
  //   LoggerUtil.e('aaaaaaaaaaaaaaa');
  //   return new Center(child: new Text("App错误，快去反馈给作者!"));
  // };

  /// Android状态栏透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
