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
import '../../ui/view/edit_view.dart';

class ChangeNamePage extends StatefulWidget {
  final String name;

  ChangeNamePage(this.name);

  @override
  _ChangeNamePageState createState() => new _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  TextEditingController _tc = new TextEditingController();
  TextEditingController _ming = new TextEditingController();
  FocusNode _f = new FocusNode();

  String initContent;

  void setInfoMethod(GlobalModel model) {
    if (!strNoEmpty(_tc.text)) {
      showToast(context, '输入的内容不能为空');
      return;
    }
    if (_tc.text.length > 12) {
      showToast(context, '输入的内容太长了');
      return;
    }
    //gen_settings

    setUsersProfileMethod(
      context,
      nickNameStr: _tc.text,
      avatarStr: model.avatar,
      callback: (data) {
        if (data.toString().contains('succ')) {
          showToast(context, '设置成功');
          model.refresh();
          Navigator.of(context).pop();
        } else
          showToast(context, '设置失败');
      },
    );




  }

  Widget body() {
    var widget = new TipVerifyInput(
      title: '好名字可以让你的朋友更容易记住你',
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
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '修改昵称'),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              new EditView(
                label: "您的姓",
                ispassword: false,
                hint: "请输入您的姓",
                controller: _tc,
                onChanged: (str) {
                },
              ),
              new EditView(
                label: "您的名字",
                ispassword: false,
                hint: "请输入您的名字",
                controller: _ming,
                onChanged: (str) {
                },
              ),
              SizedBox(height: 40,),
              new ComMomButton(
                text: "确定",
                style: TextStyle(
                    color:  Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                color:
                Color.fromRGBO(8, 191, 98, 1.0),
                onTap: () {
                  if(_tc.text==''||_ming.text==''){
                    EasyLoading.showToast("请输入完整内容");
                    return;
                  }
                  String token = SpUtil.getString("authToken") ;
                  EasyLoading.show(status: '加载中...');
                  DioUtil()
                      .post('$baseUrl/gen_settings', data: {
                    "first_name": _tc.text,
                    "last_name": _ming.text,
                    "license": AppData.licence,
                    "session_id": token,
                  }, errorCallback: (statusCode) {
                    EasyLoading.dismiss();
                    print('Http error code : $statusCode');
                    EasyLoading.showToast(statusCode);
                  }).then((data) {
                    EasyLoading.dismiss();
                    print('Http response: $data');

                    if (data != null) {
                      if (data["code"] == 200 || data["code"] == 0) {
                        EasyLoading.showToast("修改成功");
                        AppData.respprofile.data.firstName =_tc.text;
                        AppData.respprofile.data.lastName =_ming.text;
                        model.refresh();
                        Navigator.pop(context,true);

                      } else {
                        EasyLoading.showToast(data["message"]);
                      }
                    }
                  });

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
