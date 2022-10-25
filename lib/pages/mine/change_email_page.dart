import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/orther/tip_verify_Input.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../tools/sp_util.dart';

class ChangeEmailPage extends StatefulWidget {
  final String name;

  ChangeEmailPage(this.name);

  @override
  _ChangeEmailPageState createState() => new _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  TextEditingController _tc = new TextEditingController();
  FocusNode _f = new FocusNode();

  String initContent;

  void setInfoMethod(GlobalModel model) {
    if (!strNoEmpty(_tc.text)) {
      showToast(context, '输入的内容不能为空');
      return;
    }
    // if (_tc.text.length > 12) {
    //   showToast(context, '输入的内容太长了');
    //   return;
    // }
    //gen_settings

    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil()
        .post('$baseUrl/gen_settings', data: {
      "email": _tc.text,
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
          AppData.respprofile.data.email = _tc.text;
          model.refresh();
          Navigator.pop(context,true);
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });



  }

  Widget body() {
    var widget = new TipVerifyInput(
      title: '输入新的邮箱',
      defStr: initContent,
      controller: _tc,
      focusNode: _f,
      color: appBarColor,
    );

    return new SingleChildScrollView(child: new Column(children: [widget]));
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

    return new Scaffold(
      backgroundColor: appBarColor,
      appBar: new ComMomBar(title: '更改邮箱', rightDMActions: [rWidget]),
      body: new MainInputBody(color: appBarColor, child: body()),
    );
  }
}
