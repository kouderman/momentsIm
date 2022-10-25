import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/appdata.dart';
import 'package:wechat_flutter/im/info_handle.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/orther/tip_verify_Input.dart';

import '../../http/Method.dart';
import '../../tools/sp_util.dart';

class ChangeSexPage extends StatefulWidget {
  final String name;

  ChangeSexPage(this.name);

  @override
  _ChangeSexPageState createState() => new _ChangeSexPageState();
}

class _ChangeSexPageState extends State<ChangeSexPage> {
  TextEditingController _tc = new TextEditingController();
  FocusNode _f = new FocusNode();

  final List<String> languageDatas = ["男", "女"];

  String initContent;
  String sex = "M";

  void setInfoMethod(GlobalModel model) {

    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/gen_settings', data: {
      "gender": sex,
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
          if (sex == "M") {
            model.gender = 1;
            model.sex ="男";
            AppData.respprofile.data.gender = "M";
          } else {
            model.gender = 0;
            model.sex ="女";
            AppData.respprofile.data.gender = "F";

          }
          Navigator.pop(context,true);
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });
  }

  // Widget body() {
  //   var widget = new TipVerifyInput(
  //     title: '好名字可以让你的朋友更容易记住你',
  //     defStr: initContent,
  //     controller: _tc,
  //     focusNode: _f,
  //     color: appBarColor,
  //   );
  //
  //   return new SingleChildScrollView(child: new Column(children: [widget]));
  // }

  @override
  void initState() {
    super.initState();
    initContent = widget.name;
    sex = initContent;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    var body = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 40,),
            Text("男："),
            Radio(
              value: "M",
              groupValue: sex,
              onChanged: (value) {
                setState(() {
                  this.sex = value;
                  sex = value;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 40,),
            Text("女："),
            Radio(
              value: "F",
              groupValue: sex,
              onChanged: (value) {
                setState(() {
                  this.sex = value;
                  sex = value;
                });
              },
            )
          ],
        )
      ],
    );

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
      appBar: new ComMomBar(title: '更改性别', rightDMActions: [rWidget]),
      body: new MainInputBody(color: appBarColor, child: body),
    );
  }
}
