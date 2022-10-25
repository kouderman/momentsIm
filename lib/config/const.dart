import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/config/appdata.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/tools/sp_util.dart';

int appId = 1400728908;

const appBarColor = whiteColor;

const bool showtoast = false;

const preSuif = "@";
const AMapPrivacyStatement amapPrivacyStatement =
    AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);

String default_avatar =
    'https://c-ssl.duitang.com/uploads/item/201803/04/20180304085215_WGFx8.thumb.700_0.jpeg';

const urls = [
  "http://api_ip/mobile_api", //业务接口url组
];

const  locationtime = 60*60*1000;

String baseUrl =
    SpUtil.getString("newurl") == '' ?  urls[0]:SpUtil.getString("newurl");

String lineceurl  = "http://api_ip/license.php";//协议url

const Amapkey = "4e197a57f1f89bf1716f45eb7c57bc12"; //高德key

const Color ComMomBGColor = Color.fromRGBO(240, 240, 245, 1.0);

const bgColor = Color.fromRGBO(255, 255, 255, 1);

const chatBg = Color(0xffefefef);

const defStyle = TextStyle(color: Colors.white);

const mainSpace = 10.0;

const mainLineWidth = 0.3;

const lineColor = Colors.grey;

const tipColor = Color.fromRGBO(89, 96, 115, 1.0);

const mainTextColor = Color.fromRGBO(115, 115, 115, 1.0);

const labelTextColor = Color.fromRGBO(144, 144, 144, 1.0);

const itemBgColor = Color.fromRGBO(75, 75, 75, 1.0);

const itemOnColor = Color.fromRGBO(68, 68, 68, 1.0);

const btTextColor = Color.fromRGBO(112, 113, 135, 1.0);

const defIcon = 'assets/images/def_avatar.png';

const contactAssets = 'assets/images/contact/';

const defAvatar = 'http://flutterj.com/f.jpeg';

const myCode = 'http://flutterj.com/c.jpg';

const download = 'http://flutterj.com/download.png';

const helpUrl =
    'https://kf.qq.com/touch/product/wechat_app.html?scene_id=kf338';

const defContentImg =
    'https://www.runoob.com/wp-content/uploads/2015/06/image_1c58e950q14da167k1nqpu2hn5e9.png';
