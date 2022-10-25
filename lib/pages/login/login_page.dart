import 'dart:ui';

import 'package:dim/commom/win_media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/login_handle.dart';
import 'package:wechat_flutter/pages/login/active_account/active_account_view.dart';
import 'package:wechat_flutter/pages/login/findpwd/find_pwd_view.dart';
import 'package:wechat_flutter/pages/login/select_location_page.dart';
import 'package:wechat_flutter/pages/login/update_pwd/update_pwd_view.dart';
import 'package:wechat_flutter/provider/login_model.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../httpbean/resplogin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _tC = new TextEditingController();
  TextEditingController _pwd = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initEdit();
  }

  initEdit() async {
    // final user = await SharedUtil.instance.getString(Keys.account);
    // _tC.text = user ?? '';
  }

  Widget bottomItem(item) {
    return new Row(
      children: <Widget>[
        new InkWell(
          child: new Text(item, style: TextStyle(color: tipColor)),
          onTap: () {
            showToast(context, S
                .of(context)
                .notOpen + item);
          },
        ),
        item == S
            .of(context)
            .weChatSecurityCenter
            ? new Container()
            : new Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: new VerticalLine(height: 15.0),
        )
      ],
    );
  }

  Widget body() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
              left: 20.0, top: mainSpace * 3, bottom: mainSpace * 2),
          child: new Text(S
              .of(context)
              .mobileNumberLogin,
              style: TextStyle(fontSize: 25.0)),
        ),
        // new FlatButton(
        //   child: new Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 10.0),
        //     child: new Row(
        //       children: <Widget>[
        //         new Container(
        //           width: winWidth(context) * 0.25,
        //           alignment: Alignment.centerLeft,
        //           child: new Text(S.of(context).phoneCity,
        //               style: TextStyle(
        //                   fontSize: 16.0, fontWeight: FontWeight.w400)),
        //         ),
        //         new Expanded(
        //           child: new Text(
        //             model.area,
        //             style: TextStyle(
        //                 color: Colors.green,
        //                 fontSize: 16.0,
        //                 fontWeight: FontWeight.w400),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        //   onPressed: () async {
        //     final result = await routePush(new SelectLocationPage());
        //     if (result == null) return;
        //     model.area = result;
        //     model.refresh();
        //     SharedUtil.instance.saveString(Keys.area, result);
        //   },
        // ),
        new Container(
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(color: Colors.grey, width: 0.15))),
          child: new Row(
            children: <Widget>[
              new Container(
                width: winWidth(context) * 0.25,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 25.0),
                child: new Text(
                  S
                      .of(context)
                      .phoneNumber,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ),
              new Expanded(
                  child: new TextField(
                    controller: _tC,
                    maxLines: 1,
                    style: TextStyle(textBaseline: TextBaseline.alphabetic),
                    // inputFormatters: [
                    //   FilteringTextInputFormatter(new RegExp(r'[0-9]'), allow: true)
                    // ],
                    decoration: InputDecoration(
                        hintText: S
                            .of(context)
                            .phoneNumberHint,
                        border: InputBorder.none),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ))
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(color: Colors.grey, width: 0.15))),
          child: new Row(
            children: <Widget>[
              new Container(
                width: winWidth(context) * 0.25,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 25.0),
                child: new Text(
                  S
                      .of(context)
                      .inputpwd,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ),
              new Expanded(
                  child: new TextField(
                    obscureText: true,
                    controller: _pwd,
                    maxLines: 1,
                    style: TextStyle(textBaseline: TextBaseline.alphabetic),
                    // inputFormatters: [
                    //   FilteringTextInputFormatter(new RegExp(r'[0-9]'), allow: true)
                    // ],
                    decoration: InputDecoration(
                        hintText: S
                            .of(context)
                            .phoneNumberHintpwd,
                        border: InputBorder.none),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ))
            ],
          ),
        ),
        // new Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        //   child: new InkWell(
        //     child: new Text(
        //       S.of(context).userLoginTip,
        //       style: TextStyle(color: tipColor),
        //     ),
        //     onTap: () => showToast(context, S.of(context).notOpen),
        //   ),
        // ),
        new Space(height: mainSpace * 2.5),
        new ComMomButton(
          text: S
              .of(context)
              .nextStep,
          style: TextStyle(
              color: !isEnable() ? Colors.grey.withOpacity(0.8) : Colors.white),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          color: !isEnable()
              ? Color.fromRGBO(226, 226, 226, 1.0)
              : Color.fromRGBO(8, 191, 98, 1.0),
          onTap: () {
            if (_tC.text == ''||_pwd.text=='') {
              showToast(context, '请输入账号及密码');
              return;
            } else if (_tC.text.length >= 2) {
              if(showtoast){
                showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
              }
              EasyLoading.show(status: '加载中...');
              DioUtil()
                  .post('$baseUrl/login', data: {
                "username": _tC.text,
                "lat": SpUtil.getDouble("lat"),
                "lng": SpUtil.getDouble("lng"),
                "password": _pwd.text,
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
                    Resplogin resplogin = Resplogin.fromJson(data);
                    SpUtil.saveString("authToken", resplogin.auth.authToken);
                    SpUtil.saveString("sig", resplogin.auth.sig);
                    SpUtil.saveString("userid",resplogin.data.user.userId.toString());
                    SpUtil.saveString("username",_tC.text);

                    SpUtil.saveString(
                        "avatar", resplogin.data.user.coverPicture);
                    login(resplogin.data.user.userName, context);
                  } else {
                    EasyLoading.showToast(data["message"]);
                  }
                }
              });
            } else {
              showToast(context, '请输入三位或以上');
            }
          },
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            print('aa');
            // routePush(new Active_accountPage());
            routePush(new Find_pwdPage());
          },
          child: new Align(
            child: Padding(
              child: Text('找回密码', style: TextStyle(color: Color.fromRGBO(8, 191, 98, 1.0)),),
              padding: EdgeInsets.only(right: 20),),
            alignment: Alignment.centerRight,
          ),
        )
      ],
    );
  }

  bool isEnable() {
    return _tC.text != '' && _pwd.text != '';
  }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<LoginModel>(context);

    List btItem = [
      S
          .of(context)
          .retrievePW,
      S
          .of(context)
          .emergencyFreeze,
      S
          .of(context)
          .weChatSecurityCenter,
    ];

    return FlutterEasyLoading(
      child: new Scaffold(
        appBar:
        new ComMomBar(title: '', leadingImg: 'assets/images/bar_close.png'),
        body: new MainInputBody(
          color: appBarColor,
          child: new Stack(
            children: <Widget>[
              new SingleChildScrollView(child: body()),
              // new Positioned(
              //   bottom: 10,
              //   left: 0,
              //   right: 0,
              //   child: new Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: btItem.map(bottomItem).toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
