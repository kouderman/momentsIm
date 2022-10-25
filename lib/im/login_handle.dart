import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/pages/login/login_begin_page.dart';
import 'package:wechat_flutter/pages/root/root_page.dart';
import 'package:wechat_flutter/provider/global_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat_flutter/tools/sp_util.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';

Future<void> init(BuildContext context) async {
  try {
    var result = await im.init(appId);
    debugPrint('初始化结果 ======>   ${result.toString()}');
  } on PlatformException {
    showToast(context, "初始化失败");
  }
}

Future<void> login(String userName, BuildContext context) async {
  final model = Provider.of<GlobalModel>(context, listen: false);

    String sig = SpUtil.getString("sig");
    LoggerUtil.e("im============>" + sig);
    LoggerUtil.e("im============>" + userName);
    var result = await im.imLogin(userName,
        sig);
  LoggerUtil.e('login::' + result.toString());
    if (result.toString().contains('ucc')) {

      model.account = userName;
      model.goToLogin = false;
      await SharedUtil.instance.saveString(Keys.account, userName);
      await SharedUtil.instance.saveBoolean(Keys.hasLogged, true);
      // model.refresh();
      await routePushAndRemove(new RootPage());
    } else {
      LoggerUtil.e('error::' + result.toString());
    }
  }


Future<void> loginOut(BuildContext context) async {
  final model = Provider.of<GlobalModel>(context, listen: false);

  try {
    var result = await im.imLogout();
    LoggerUtil.e('logout ::' + result.toString());
    if (result.toString().contains('ucc')) {
      showToast(context, '登出成功');
    } else {
      print('error::' + result.toString());
    }
    model.goToLogin = true;
    model.refresh();
    await SharedUtil.instance.saveBoolean(Keys.hasLogged, false);
    await routePushAndRemove(new LoginBeginPage());
  } on PlatformException {
    model.goToLogin = true;
    model.refresh();
    await SharedUtil.instance.saveBoolean(Keys.hasLogged, false);
    await routePushAndRemove(new LoginBeginPage());
  }
}
