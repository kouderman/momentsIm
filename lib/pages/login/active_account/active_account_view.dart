import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/pages/login/login_page.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/text_view.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import '../../../ui/view/edit_view.dart';
import 'active_account_controller.dart';

class Active_accountPage extends StatelessWidget {

  TextEditingController emailC = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String account  = SpUtil.getString("username");
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '激活账号'),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              new TextView(
                label: "用户名",
                hint: account,
                onChanged: (str) {
                },
              ),
              new EditView(
                label: "邮箱激活码",
                hint: "请输入邮箱中的激活码",
                controller: emailC,
                onChanged: (str) {
                },
              ),

              SizedBox(height: 40,),
              new ComMomButton(
                text: "激活",
                style: TextStyle(
                    color:  Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                color:
                Color.fromRGBO(8, 191, 98, 1.0),
                onTap: () {
                  if(emailC.text==''){
                    EasyLoading.showToast("请输入邮箱激活码");
                    return;
                  }
                  EasyLoading.show(status: '加载中...');
                  DioUtil()
                      .post('$baseUrl/active', data: {
                    "license": AppData.licence,
                    "code": emailC.text,
                    "username": account,
                  }, errorCallback: (statusCode) {
                    EasyLoading.dismiss();
                    print('Http error code : $statusCode');
                    EasyLoading.showToast(statusCode);
                  }).then((data) {
                    EasyLoading.dismiss();
                    print('Http response: $data');

                    if (data != null) {
                      if (data["code"] == 200 || data["code"] == 0) {
                        routePush(LoginPage());
                        EasyLoading.showToast("注册成功");
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
