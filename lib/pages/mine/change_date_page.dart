import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/orther/tip_verify_Input.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../tools/sp_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../util/AgeByBirthUtils.dart';

class ChangeDatePage extends StatefulWidget {
  final String name;

  ChangeDatePage(this.name);

  @override
  _ChangeEmailPageState createState() => new _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeDatePage> {
  TextEditingController _tc = new TextEditingController();
  FocusNode _f = new FocusNode();

  String mdate = '';

  String initContent;

  void setInfoMethod(GlobalModel model) {
    // if (!strNoEmpty(_tc.text)) {
    //   showToast(context, '输入的内容不能为空');
    //   return;
    // }
    // if (_tc.text.length > 12) {
    //   showToast(context, '输入的内容太长了');
    //   return;
    // }
    //gen_settings

    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/gen_settings', data: {
      "birthday": mdate,
      "session_id": authToken,
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
          // setUsersProfileMethod(
          //   context,
          //   nickNameStr: _tc.text,
          //   avatarStr: model.avatar,
          //   callback: (data) {
          //     if (data.toString().contains('succ')) {
          //       showToast(context, '设置成功');
          //       model.refresh();
          //       Navigator.of(context).pop();
          //     } else
          //       showToast(context, '设置失败');
          //   },
          // );
          AppData.respprofile.data.birthday = mdate;
          model.refresh();
          Navigator.pop(context, true);
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });
  }

  Widget body() {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 80,
        ),
        Text(mdate),
        SizedBox(
          height: 20,
        ),
        new ComMomButton(
          text: '请选择出生日期',
          style: TextStyle(color: Colors.white),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          color: Color.fromRGBO(8, 191, 98, 1.0),
          onTap: () {
            showDate();
          },
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    initContent = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    var rWidget = new ComMomButton(
      text: '保存',
      style: TextStyle(color: Colors.white),
      width: 55.0,
      margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
      radius: 4.0,
      onTap: () => setInfoMethod(model),
    );

    return FlutterEasyLoading(
      child: new Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '更改生日', rightDMActions: [rWidget]),
        body: new MainInputBody(color: appBarColor, child: body()),
      ),
    );
  }

  void showDate() {
    DatePicker.showDatePicker(context,
        // 是否展示顶部操作按钮
        showTitleActions: true,
        // 最小时间
        minTime: DateTime(1980, 3, 5),
        // 最大时间
        maxTime: DateTime.now(),
        // change事件
        onChanged: (date) {
      print('change $date');
    },
        // 确定事件
        onConfirm: (date) {
      mdate = "${date.year}-${date.month}-${date.day}";
      int age = AgeByBirthUtils.getAge(date);
      LoggerUtil.e(age.toString());
      if (age < 18) {
        showToast(context, '你的年龄不满18岁');
        return;
      }

      setState(() {});
      print('confirm $date');
    },
        // 当前时间
        currentTime: DateTime.now(),
        // 语言
        locale: LocaleType.zh);
  }
}
