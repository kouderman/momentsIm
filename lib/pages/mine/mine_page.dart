import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/im/all_im.dart';
import 'package:wechat_flutter/pages/login/update_pwd/update_pwd_view.dart';
import 'package:wechat_flutter/pages/mine/personal_info_page.dart';
import 'package:wechat_flutter/pages/settings/language_page.dart';
import 'package:wechat_flutter/pages/wallet/pay_home_page.dart';
import 'package:geolocator/geolocator.dart';

import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/list_tile_view.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../httpbean/respverify.dart';
import '../../tools/sp_util.dart';
import '../../util/HomePage.dart';
import '../chat/chat_page.dart';
import '../wechat_friends/friendcircle/friendcircle_view.dart';
import '../wechat_friends/page/wechat_friends_circle.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage> {
  String nickname = '';
  Position _currentPosition;

  Future<void> action(name) async {
    switch (name) {
      case '退出':
        showCupertinoDialog(
            //dialog使用
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('提示'),
                content: const Text('确认退出吗？'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('取消'),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('确认'),
                    onPressed: () {
                      // Navigator.pop(context);
                      String token = SpUtil.getString("authToken");
                      String email = SpUtil.getString("email");
                      EasyLoading.show(status: '加载中...');
                      DioUtil().post(
                          '$baseUrl/logout',
                          data: {
                            "session_id": token,
                            "license": AppData.licence,
                            "email": email,
                          }, errorCallback: (statusCode) {
                        EasyLoading.dismiss();
                        print('Http error code : $statusCode');
                        EasyLoading.showToast(statusCode);
                      }).then((data) {
                        EasyLoading.dismiss();
                        print('Http response: $data');

                        if (data != null) {
                          if (data["code"] == 200 || data["code"] == 0) {
                            loginOut(context);
                          } else {
                            EasyLoading.showToast(data["message"]);
                          }
                        }
                      });
                    },
                  ),
                ],
              );
            });

        break;
      case '已认证':

         toVerify();


        break;
      case '申请认证':
        toVerify();
        break;
      case '修改密码':
        routePush(new Update_pwdPage());
        break;
      case '我的朋友圈':
        routePush(new FriendcirclePage(
            SpUtil.getString("userid"),
            SpUtil.getString("cover"),
            SpUtil.getString("avatar"),
            AppData.respprofile.data.name));
        break;
      case '隐私设置':
        showToast(context, '待更新');
        // routePush(new Friend_postPage());
        break;
      default:
        routePush(new LanguagePage());
        break;
    }
  }

  Widget buildContent(item) {
    return new ListTileView(
      border: item['label'] == getcertdesc() ||
              item['label'] == '退出' ||
              item['label'] == '表情'
          ? null
          : Border(bottom: BorderSide(color: lineColor, width: 0.2)),
      title: item['label'],
      titleStyle: TextStyle(fontSize: 15.0,color: titleColor),
      isLabel: false,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      icon: item['icon'],
      margin: EdgeInsets.symmetric(
          vertical: item['label'] == getcertdesc() || item['label'] == '设置'
              ? 10.0
              : 0.0),
      onPressed: () => action(item['label']),
      width: 25.0,
      fit: BoxFit.cover,
      horizontal: 15.0,
    );
  }

  Widget dynamicAvatar(avatar, {size}) {
    return new ImageView(
        img: avatar,
        width: size ?? null,
        height: size ?? null,
        fit: BoxFit.fill);
  }

  String getcertdesc() {
    return AppData.respprofile.data.isVerified ? '已认证' : '申请认证';
  }

  Widget body(GlobalModel model) {
    List data = [
      {'label': getcertdesc(), 'icon': 'assets/images/mine/ic_pay.png'},
      {'label': '我的朋友圈', 'icon': 'assets/images/favorite.webp'},
      // {'label': '朋友圈', 'icon': 'assets/images/mine/ic_card_package.png'},
      {'label': '设置语言', 'icon': 'assets/images/mine/ic_card_package.png'},
      // {'label': '设置语言', 'icon': 'assets/images/mine/ic_emoji.png'},
      {'label': '修改密码', 'icon': 'assets/images/mine/ic_emoji.png'},
      {'label': '隐私设置', 'icon': 'assets/images/mine/ic_emoji.png'},
      {'label': '退出', 'icon': 'assets/images/mine/ic_setting.png'},
    ];

    var row = [
      new SizedBox(
        width: 60.0,
        height: 60.0,
        child: new ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child:
              new Image.network(SpUtil.getString("avatar"), fit: BoxFit.cover),
        ),
      ),
      new Container(
        margin: EdgeInsets.only(left: 15.0),
        height: 60.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              nickname,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            new Text(
              '账号：' + model.account,
              style: TextStyle(color: mainTextColor),
            ),
          ],
        ),
      ),
      new Spacer(),
      new Container(
        width: 13.0,
        margin: EdgeInsets.only(right: 12.0),
        child: new Image.asset('assets/images/mine/ic_small_code.png',
            color: mainTextColor.withOpacity(0.5), fit: BoxFit.cover),
      ),
      new Image.asset('assets/images/ic_right_arrow_grey.webp',
          width: 7.0, fit: BoxFit.cover)
    ];

    return new Column(
      children: <Widget>[
        new InkWell(
          child: new Container(
            color: Colors.white,
            height: (topBarHeight(context) * 2.5) - 10,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center, children: row),
          ),
          onTap: () => routePush(new PersonalInfoPage()),
        ),
        new Column(children: data.map(buildContent).toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    final model = Provider.of<GlobalModel>(context);
    model.refresh();
    nickname = AppData.respprofile.data.firstName +
        "," +
        AppData.respprofile.data.lastName;

    return new Container(
      color: appBarColor,
      child: new SingleChildScrollView(child: body(model)),
    );
  }

  void toVerify() {
    DioUtil()
        .post('$baseUrl/im_on_duty', data: {
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Respverify respverify = Respverify.fromJson(data);
          routePush(new ChatPage(id: respverify.data.username, title: '系统管理员', type: 1));
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });
  }
}
