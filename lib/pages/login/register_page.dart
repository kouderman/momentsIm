import 'dart:collection';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/pages/login/active_account/active_account_view.dart';
import 'package:wechat_flutter/pages/login/login_begin_page.dart';
import 'package:wechat_flutter/pages/login/login_page.dart';
import 'package:wechat_flutter/provider/login_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/edit_view.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../tools/sp_util.dart';
import 'select_location_page.dart';
import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {

  StreamSubscription<Map<String, Object>> _locationListener;
  @override
  void dispose() {
    super.dispose();
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
  }

  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      _startLocation();
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  @override
  void initState() {
    super.initState();
    AMapFlutterLocation.updatePrivacyShow(true, true);

    AMapFlutterLocation.updatePrivacyAgree(true);
     getLocation();



  }
  void _setLocationOption() {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  void getLocation() async {
    if (await Permission.location.request().isGranted) {
      AMapFlutterLocation.updatePrivacyShow(true, true);

      AMapFlutterLocation.updatePrivacyAgree(true);

      /// 动态申请定位权限


      AMapFlutterLocation.setApiKey(Amapkey, "dfb64c0463cb53927914364b5c09aba0");

      _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
        LoggerUtil.e(result);

        lat = result["latitude"].toString();
        lng = result["longitude"].toString();
        SpUtil.saveDouble("lat", result["latitude"]);
        SpUtil.saveDouble("lng", result["longitude"]);
        SpUtil.saveDouble("locationtime", new DateTime.now().millisecondsSinceEpoch.toDouble());

      });
      _setLocationOption();
      _startLocation();
    }


  }

  bool isSelect = false;

  String lat = "";
  String lng = "";

  FocusNode nickF = new FocusNode();
  TextEditingController nickC = new TextEditingController();
  TextEditingController emailC = new TextEditingController();
  FocusNode phoneF = new FocusNode();
  TextEditingController phoneC = new TextEditingController();
  FocusNode pWF = new FocusNode();
  TextEditingController pWC = new TextEditingController();
  TextEditingController pWCTwo = new TextEditingController();
  TextEditingController firstN = new TextEditingController();
  TextEditingController lastC = new TextEditingController();
  TextEditingController genderC = new TextEditingController();

  String localAvatarImgPath = '';
  int groupValue = 0;

  String sex = "F";

  _openGallery() async {
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      localAvatarImgPath = img.path;
      setState(() {});
    } else {
      return;
    }
  }

  void updateGroupValue(int v) {
    if (v == 1) {
      sex = "M";
    } else {
      sex = "F";
    }
    setState(() {
      groupValue = v;
    });
  }

  Widget body(LoginModel model) {
    var column = [
      new Padding(
        padding: EdgeInsets.only(
            left: 5.0, top: mainSpace * 3, bottom: mainSpace * 2),
        child:
            new Text(S.of(context).register, style: TextStyle(fontSize: 25.0)),
      ),
      new Row(
        children: <Widget>[
          new Expanded(
            child: new EditView(
              label: S.of(context).nickName,
              hint: S.of(context).exampleName,
              bottomLineColor:
                  nickF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
              focusNode: nickF,
              controller: nickC,
              onTap: () => setState(() {}),
            ),
          ),
          // new InkWell(
          //   child: !strNoEmpty(localAvatarImgPath)
          //       ? new Image.asset('assets/images/login/select_avatar.webp',
          //           width: 60.0, height: 60.0, fit: BoxFit.cover)
          //       : new ClipRRect(
          //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //           child: new Image.file(File(localAvatarImgPath),
          //               width: 60.0, height: 60.0, fit: BoxFit.cover),
          //         ),
          //   onTap: () => _openGallery(),
          // ),
        ],
      ),
      // new InkWell(
      //   child: new Padding(
      //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      //     child: new Row(
      //       children: <Widget>[
      //         new Container(
      //           width: winWidth(context) * 0.25,
      //           alignment: Alignment.centerLeft,
      //           child: new Text(S.of(context).phoneCity,
      //               style:
      //                   TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
      //         ),
      //         new Expanded(
      //           child: new Text(
      //             model.area,
      //             style: TextStyle(
      //               color: Colors.green,
      //               fontSize: 16.0,
      //               fontWeight: FontWeight.w400,
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      //   onTap: () async {
      //     final result = await routePush(new SelectLocationPage());
      //     if (result == null) return;
      //     model.area = result;
      //     model.refresh();
      //     SharedUtil.instance.saveString(Keys.area, result);
      //   },
      // ),
      new EditView(
        label: S.of(context).eamil,
        hint: S.of(context).eamilTip,
        controller: emailC,
        bottomLineColor:
            pWF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
        onTap: () => setState(() {}),
        onChanged: (str) {
          setState(() {});
        },
      ),
      new EditView(
        label: S.of(context).passWord,
        hint: S.of(context).pwTip,
        controller: pWC,
        bottomLineColor:
            pWF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
        onTap: () => setState(() {}),
        onChanged: (str) {
          setState(() {});
        },
      ),
      new EditView(
        label: S.of(context).passWordTwo,
        hint: S.of(context).passWordTwoHint,
        controller: pWCTwo,
        bottomLineColor:
            pWF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
        onTap: () => setState(() {}),
        onChanged: (str) {
          setState(() {});
        },
      ),
      new EditView(
        label: S.of(context).xing,
        hint: S.of(context).xinghint,
        controller: firstN,
        bottomLineColor:
            pWF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
        onTap: () => setState(() {}),
        onChanged: (str) {
          setState(() {});
        },
      ),
      new EditView(
        label: S.of(context).xingname,
        hint: S.of(context).xingnamehint,
        controller: lastC,
        bottomLineColor:
            pWF.hasFocus ? Colors.green : lineColor.withOpacity(0.5),
        onTap: () => setState(() {}),
        onChanged: (str) {
          setState(() {});
        },
      ),
      new Row(
        children: [
          new Text(S.of(context).gender,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
          new Radio(
              value: 0,
              groupValue: groupValue, //当value和groupValue一致的时候则选中
              activeColor: Colors.green,
              onChanged: (T) {
                updateGroupValue(T);
              }),
          Text(S.of(context).female),
          SizedBox(
            width: 0,
          ),
          new Radio(
              value: 1,
              activeColor: Colors.green,
              groupValue: groupValue,
              onChanged: (T) {
                updateGroupValue(T);
              }),
          Text(S.of(context).male),
        ],
      ),
      new Space(height: mainSpace * 2),
      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new InkWell(
            child: new Image.asset(
              'assets/images/login/${isSelect ? 'ic_select_have.webp' : 'ic_select_no.png'}',
              width: 25.0,
              height: 25.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              setState(() => isSelect = !isSelect);
            },
          ),
          new Padding(
            padding: EdgeInsets.only(left: mainSpace / 2),
            child: new Text(
              S.of(context).readAgree,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          new InkWell(
            child: new Text(
              S.of(context).protocolName,
              style: TextStyle(color: tipColor),
            ),
            onTap: () => routePush(new WebViewPage(
                lineceurl, S.of(context).protocolTitle)),
          ),
        ],
      ),
      new ComMomButton(
        text: S.of(context).register,
        style: TextStyle(
            color: !isEnable() ? Colors.grey.withOpacity(0.8) : Colors.white),
        margin: EdgeInsets.only(top: 20.0),
        color: !isEnable()
            ? Color.fromRGBO(226, 226, 226, 1.0)
            : Color.fromRGBO(8, 191, 98, 1.0),
        onTap: () {
          if (!strNoEmpty(pWC.text)) return;
          if (pWC.text != pWCTwo.text) {
            showToast(context, '二次密码不一致!');
            return;
          }
          EasyLoading.show(status: '加载中...');
          DioUtil().post('$baseUrl/signup', data: {
            "email": emailC.text,
            "license": AppData.licence,
            "username": nickC.text,
            "last_name": lastC.text,
            "first_name": firstN.text,
            "password": pWC.text,
            "lat": lat,
            "lng": lng,
            "lang": 'china',
            "gender": sex,
            "avatar": "nan",
          }, errorCallback: (statusCode) {
            dismissEasyLoading();
            print('Http error code : $statusCode');
          }).then((data) {
            dismissEasyLoading();

            var code = data["code"];

            if (code == 200 || code == 0 || code == 201) {
              if (code == 200) {
                routePush(new LoginPage());
              } else if (code == 201) {
                routePushAndRemove(new Active_accountPage());
                SpUtil.saveString("username", nickC.text);
              }
            } else {
              dismissEasyLoading();
              EasyLoading.showToast(data["message"].toString());
            }

            print('Http response: $data');
          });
        },
      ),
    ];

    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: column),
    );
  }

  bool isEnable() {
    return nickC.text != '' &&
        emailC.text != '' &&
        pWC.text != '' &&
        firstN.text != '' &&
        lastC.text != '' &&
        pWC.text != '' &&
        pWCTwo.text != '';
  }

  void dismissEasyLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);

    return FlutterEasyLoading(
      child: new Scaffold(
        appBar:
            new ComMomBar(title: "", leadingImg: 'assets/images/bar_close.png'),
        body: new MainInputBody(
          color: appBarColor,
          child: new SingleChildScrollView(child: body(model)),
          onTap: () => setState(() => {}),
        ),
      ),
    );
  }
}
