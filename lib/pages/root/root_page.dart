import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/appdata.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/http/api.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/im/location_manager.dart';
import 'package:wechat_flutter/main.dart';
import 'package:wechat_flutter/pages/circleindex/circleindex_view.dart';
import 'package:wechat_flutter/pages/contacts/contacts_page.dart';
import 'package:wechat_flutter/pages/discover/discover_page.dart';
import 'package:wechat_flutter/pages/home/home_page.dart';
import 'package:wechat_flutter/pages/mine/mine_page.dart';
import 'package:wechat_flutter/pages/root/root_tabbar.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../http/Method.dart';
import '../../httpbean/respprofile.dart';
import '../../httpbean/version.dart';
import '../../provider/global_model.dart';
import '../../routerlistener/PageChangeUtil.dart';
import '../../routerlistener/RouteEvent.dart';
import '../../tools/sp_util.dart';
import '../../ui/dialog/update_dialog.dart';
import '../contact/index_view.dart';
import 'UserEvent.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with RouteAware {
  String _title = "消息";

  String _customJson = '';

  Future<bool> checkUpdateVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionCode = packageInfo.version;

    String token = SpUtil.getString("authToken");

    bool check = false;
    DioUtil().post('$baseUrl/version', data: {
      "session_id": token,
      "version": versionCode,
      "device_type": 'android',
      "license": AppData.licence,
      "appid": 'com.app.okchat',
    }, errorCallback: (statusCode) {
      print('Http error code : $statusCode');
    }).then((data) {
      print('Http response: $data');
      LoggerUtil.e(data.toString());
      Version v = Version.fromJson(data);
      if (data != null) {
        if (v.code == 200 || v.code == 0) {
        } else if (v.code == 409) {

          if(v.data.option=="mandatory"){
            showDialog(
                context: context,
                builder: (ctx2) {
                  return UpdateDialog(
                    updateInfo: "有新版本更新",
                    updateUrl: v.data.url,
                    isForce: true,
                  );
                });
          }else {
            showDialog(
                context: context,
                builder: (ctx2) {
                  return UpdateDialog(
                    updateInfo: "有新版本更新",
                    updateUrl: v.data.url,
                    isForce: false,
                  );
                });
          }


        }
      }
    });

    return check;
  }

  Future<void> loadJsonFromAsset() async {
    // _customJson = await rootBundle.loadString('assets/update_custom.json');
  }

  ///初始化
  void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(

              ///是否输出日志
              debug: true,

              ///是否使用post请求
              isPost: false,

              ///post请求是否是上传json
              isPostJson: false,

              ///请求响应超时时间
              timeout: 25000,

              ///是否开启自动模式
              isWifiOnly: false,

              ///是否开启自动模式
              isAutoMode: false,

              ///需要设置的公共参数
              supportSilentInstall: false,

              ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
              enableRetry: false)
          .then((value) {})
          .catchError((error) {
        print(error);
      });

      FlutterXUpdate.setUpdateHandler(
          onUpdateError: (Map<String, dynamic> message) async {
        print(message);
        //下载失败
        if (message["code"] == 4000) {
          FlutterXUpdate.showRetryUpdateTipDialog(
              retryContent: 'Github被墙无法继续下载，是否考虑切换蒲公英下载？',
              retryUrl: 'https://www.pgyer.com/flutter_learn');
        }
      }, onUpdateParse: (String json) async {
        //这里是自定义json解析
        return customParseJson(json);
      });
    } else {}
  }

  UpdateEntity customParseJson(String json) {
    return UpdateEntity(
      hasUpdate: true,
      downloadUrl: "https:\/\/downloadsource.huitouke.cn\/im.apk",
    );
  }



  @override
  void initState() {
    super.initState();
    // initXUpdate();
    // loadJsonFromAsset();
    LocationManager.getInstance().init();
    checkUpdateVersion();

    PageChangeUtil.instance.changeStream.listen((event) {
      switch (event.type) {
        case ActionType.DID_REMOVE:
          LoggerUtil.e('ActionType.DID_REMOVE');
          break;
        case ActionType.DID_POP:
          if (mounted) {
            LoggerUtil.e('ActionType.DID_POP');

            if (event.pageNmae.toString() == "/") {
              // isListener = true;
              LoggerUtil.e(event.isCurrent);
            }
          }
          break;
        case ActionType.DID_PUSH:
          LoggerUtil.e('ActionType.DID_PUSH');
          LoggerUtil.e(event.isCurrent);
          if (event.pageNmae.toString() == "ChatPage") {
            // isListener = false;
            LoggerUtil.e(event.isCurrent);
          }
          break;
        case ActionType.DID_REPLACE:
          LoggerUtil.e('ActionType.DID_REPLACE');
          break;
        default:
          break;
      }
    });
    ifBrokenNetwork();
    updateApi(context);

    eventBus.on<UserEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      print(event.count);
      if (event.count > 0) {
        LoggerUtil.e("count---------- ${event.count}");
        _title = "消息(${event.count})";
        setState(() {});
      } else {
        _title = "消息";
        setState(() {});
      }
    });

    String authToken = SpUtil.getString("authToken");
    String userid = SpUtil.getString("userid");
    DioUtil().post('$baseUrl/profile', data: {
      "session_id": authToken,
      "user_id": userid,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      print('Http error code : $statusCode');
    }).then((data) {
      var code = data["code"];

      if (code == 200 || code == 0 || code == 201) {
        if (code == 200) {
          Respprofile respProfile = Respprofile.fromJson(data);
          AppData.respprofile = respProfile;
          final model = Provider.of<GlobalModel>(context, listen: false);
          // LoggerUtil.e("全局修改用户信息=======================");
          model.refresh();

          SpUtil.saveString("avatar", respProfile.data.avatar);
          SpUtil.saveString("cover", respProfile.data.cover);
        }
      } else {}

      print('Http response: $data');
    });
  }

  ifBrokenNetwork() async {
    final ifNetWork = await SharedUtil.instance.getBoolean(Keys.brokenNetwork);
    if (ifNetWork) {
      /// 监测网络变化
      subscription.onConnectivityChanged
          .listen((ConnectivityResult result) async {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          final currentUser = await im.getCurrentLoginUser();
          if (currentUser == '' || currentUser == null) {
            final account = await SharedUtil.instance.getString(Keys.account);
            im.imAutoLogin(account);
          }
          await SharedUtil.instance.saveBoolean(Keys.brokenNetwork, false);
        }
      });
    } else {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    LoggerUtil.e("------> didPush");
    super.didPush();
    if(mounted){
      LoggerUtil.e("--root----> didPush");

    }
  }

  @override
  void didPop() {
    LoggerUtil.e("------> didPop");
    super.didPop();
  }

  @override
  void didPopNext() {
    LoggerUtil.e("------> didPopNext");
    super.didPopNext();
    if(mounted){
      LoggerUtil.e("--root----> didPopNext");
    }
  }

  @override
  void didPushNext() {
    LoggerUtil.e("------> didPushNext");

    super.didPushNext();
  }

  @override
  void dispose() {
    LoggerUtil.e('rootpage diapose------------');
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TabBarModel> pages = <TabBarModel>[
      new TabBarModel(
          title: _title,
          icon: new LoadImage("assets/images/tabbar_chat_c.webp"),
          selectIcon: new LoadImage("assets/images/tabbar_chat_s.webp"),
          page: new HomePage()),
      new TabBarModel(
        title: S.of(context).contacts,
        icon: new LoadImage("assets/images/tabbar_contacts_c.webp"),
        selectIcon: new LoadImage("assets/images/tabbar_contacts_s.webp"),
        page: new IndexPage(),
      ),
      new TabBarModel(
        title: S.of(context).discover,
        icon: new LoadImage("assets/images/tabbar_discover_c.webp"),
        selectIcon: new LoadImage("assets/images/tabbar_discover_s.webp"),
        page: new CircleIndexPage(),
      ),
      new TabBarModel(
        title: S.of(context).me,
        icon: new LoadImage("assets/images/tabbar_me_c.webp"),
        selectIcon: new LoadImage("assets/images/tabbar_me_s.webp"),
        page: new MinePage(),
      ),
    ];
    return new Scaffold(
      key: scaffoldGK,
      body: new RootTabBar(pages: pages, currentIndex: 0),
    );
  }
}

class LoadImage extends StatelessWidget {
  final String img;

  LoadImage(this.img);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 2.0),
      child: new Image.asset(img, fit: BoxFit.cover, gaplessPlayback: true),
    );
  }
}
