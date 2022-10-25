import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/http/api.dart';
import 'package:wechat_flutter/httpbean/Country.dart';
import 'package:wechat_flutter/pages/area/country/country_view.dart';
import 'package:wechat_flutter/pages/mine/areaevent.dart';
import 'package:wechat_flutter/pages/mine/code_page.dart';
import 'package:wechat_flutter/tools/commom.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/pages/mine/change_name_page.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/ui/orther/label_row.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../httpbean/respavatar.dart';
import '../../tools/sp_util.dart';
import 'package:http_parser/http_parser.dart';

import 'change_date_page.dart';
import 'change_email_page.dart';
import 'change_sex_page.dart';
import 'change_sign_page.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  EventBus eventBus = EventBus();

  String sign = '';
  String bir = '';
  String sex = '';
  String email = '';
  String nickname = '';
  String area = '';

  @override
  void initState() {
    super.initState();
    eventBus.on<AreaEvent>().listen((event) {
      print("onevent");
      setState(() {});
    });
  }

  action(v) {
    if (v == '二维码名片') {
      routePush(new CodePage());
    } else if (v == '我的地址') {
      Navigator.of(context)
          .push(
            new MaterialPageRoute(builder: (_) => CountryPage()),
          )
          .then((val) => setState(() {}));

      // String authToken = SpUtil.getString("authToken");
      // DioUtil()
      //     .post('$baseUrl/area', data: {
      //   "action": "country",
      //   "session_id": authToken,
      //   "license": AppData.licence,
      // }, errorCallback: (statusCode) {
      //   EasyLoading.dismiss();
      //   print('Http error code : $statusCode');
      //   EasyLoading.showToast(statusCode);
      // }).then((data) {
      //   EasyLoading.dismiss();
      //   print('Http response: $data');
      //
      //   if (data != null) {
      //     if (data["code"] == 200 || data["code"] == 0) {
      //     } else {
      //       EasyLoading.showToast(data["message"]);
      //     }
      //   }
      // });

      // showModalBottomSheet(
      //   context: context,
      //   builder: (context) => Container(
      //     child:ShaiXuanSelectWidget(PinpaiListData: ["中国","美国"]),
      //     height: 600,
      //   ),
      // ).then((val) {
      //   print(val);
      // });
    } else if (v == '隐私设置') {
      showToast(context, '待更新');
    } else {
      print(v);
    }
  }

  var dio = Dio();

  // void uploadImg(imageUrl,name) async{
  //   FormData formData = FormData.fromMap({
  //     "name": "admin",
  //     "password": 123456,
  //     "file": await MultipartFile.fromFile(
  //         imageUrl,
  //         filename: "avatar.img"
  //     )
  //   });
  //   var result = await dio.post("$baseUrl/upload_avatar", data: formData);
  //   print(result);
  // }

  _openGallery() async {
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      var path = img.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);

      Map<String, dynamic> map = Map();
      map["license"] = AppData.licence;
      map["session_id"] = SpUtil.getString("authToken");
      map["file"] = await MultipartFile.fromFile(path,
          filename: name, contentType: new MediaType("image", "jpeg"));

      FormData formData2 = FormData.fromMap(map);

      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      final model = Provider.of<GlobalModel>(context, listen: false);

      // EasyLoading.show(status: '加载中...');
      DioUtil().post('$baseUrl/upload_avatar',
          data: formData2, errorCallback: (statusCode) {
        EasyLoading.dismiss();
        print('Http error code : $statusCode');
        // EasyLoading.showToast(statusCode);
      }).then((data) {
        // EasyLoading.dismiss();
        print('Http response: $data');

        if (data != null) {
          if (data["code"] == 200 || data["code"] == 0) {
            showToast(context, '上传成功');
            Respavatar respavatar = Respavatar.fromJson(data);
            AppData.respprofile.data.avatar = respavatar.data.url;

            SpUtil.saveString("avatar", respavatar.data.url);

            setUsersProfileMethod(
              context,
              // nickNameStr: model.nickName,
              avatarStr: respavatar.data.url,
              callback: (data) {
                if (data.toString().contains('succ')) {
                  model.refresh();
                } else {}
              },
            );
          } else {}
        }
      });
    }
  }

  Widget dynamicAvatar(avatar, {size}) {
    if (isNetWorkImg(avatar)) {
      return new CachedNetworkImage(
          imageUrl: avatar,
          cacheManager: cacheManager,
          width: size ?? null,
          height: size ?? null,
          fit: BoxFit.fill);
    } else {
      return new Image.asset(avatar,
          fit: BoxFit.fill, width: size ?? null, height: size ?? null);
    }
  }

  Widget body(GlobalModel model) {
    List data = [
      {'label': '账号', 'value': model.account},
      // {'label': '二维码名片', 'value': ''},
      {'label': '隐私设置', 'value': ''},
      {'label': '我的地址', 'value': area},
    ];

    var content = [
      new LabelRow(
        label: '头像',
        isLine: true,
        isRight: true,
        rightW: new SizedBox(
          width: 55.0,
          height: 55.0,
          child: new ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: new Image.network(SpUtil.getString("avatar"),
                  fit: BoxFit.cover)),
        ),
        onPressed: () => _openGallery(),
      ),
      new LabelRow(
        label: '昵称',
        isLine: true,
        isRight: true,
        rValue: nickname,
        onPressed: () => Navigator.of(context)
            .push(
              new MaterialPageRoute(builder: (_) => ChangeNamePage('')),
            )
            .then((val) => setState(() {})),
      ),
      new LabelRow(
        label: '签名',
        isLine: true,
        isRight: true,
        rValue: sign,
        onPressed: () => Navigator.of(context)
            .push(
              new MaterialPageRoute(builder: (_) => ChangeSignPage(model.sign)),
            )
            .then((val) => setState(() {})),
      ),
      new LabelRow(
        label: '邮箱',
        isLine: true,
        isRight: true,
        rValue: email,
        onPressed: () => Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) => ChangeEmailPage(model.email)),
            )
            .then((val) => setState(() {})),
      ),
      new LabelRow(
        label: '出生日期',
        isLine: true,
        isRight: true,
        rValue: AppData.respprofile.data.birthday,
        onPressed: () => Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) =>
                      ChangeDatePage(model.gender == 1 ? "M" : "F")),
            )
            .then((val) => setState(() {})),
      ),
      new LabelRow(
        label: '性别',
        isLine: true,
        isRight: true,
        rValue: sex,
        onPressed: () => Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) => ChangeSexPage(model.gender == 1 ? "M" : "F")),
            )
            .then((val) => setState(() {})),
      ),
      new Column(
        children: data.map((item) => buildContent(item, model)).toList(),
      ),
    ];

    return new Column(children: content);
  }

  Widget buildContent(item, GlobalModel model) {
    return new LabelRow(
      label: item['label'],
      rValue: item['value'],
      isLine: item['label'] == '我的地址' || item['label'] == '更多' ? false : true,
      isRight: item['label'] == '账号' ? false : true,
      margin: EdgeInsets.only(bottom: item['label'] == '隐私设置' ? 10.0 : 0.0),
      rightW: item['label'] == '二维码名片'
          ? new Image.asset('assets/images/mine/ic_small_code.png',
              color: mainTextColor.withOpacity(0.7))
          : new Container(),
      onPressed: () => action(item['label']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);
    model.refresh();
    sign = AppData.respprofile.data.aboutYou;
    email = AppData.respprofile.data.email;
    bir = AppData.respprofile.data.birthday;
    sex = AppData.respprofile.data.gender == "F" ? "女" : "男";
    nickname = AppData.respprofile.data.firstName +
        "," +
        AppData.respprofile.data.lastName;
    area = model.area;
    return new Scaffold(
      backgroundColor: appBarColor,
      appBar: new ComMomBar(title: '个人信息'),
      body: new SingleChildScrollView(child: body(model)),
    );
  }
}
