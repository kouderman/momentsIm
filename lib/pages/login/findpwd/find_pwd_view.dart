import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import '../../../ui/view/edit_view.dart';
import 'find_pwd_controller.dart';

class Find_pwdPage extends StatelessWidget {

  TextEditingController emailC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '找回密码'),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              new EditView(
                label: "邮箱",
                hint: "请输入你的邮箱",
                controller: emailC,
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
                  if(emailC.text==''){
                    EasyLoading.showToast("请输入邮箱");
                    return;
                  }
                  String token = SpUtil.getString("authToken") ;
                  EasyLoading.show(status: '加载中...');
                  DioUtil()
                      .post('$baseUrl/resetpassword', data: {
                    "license": AppData.licence,
                    "email": emailC.text,
                  }, errorCallback: (statusCode) {
                    EasyLoading.dismiss();
                    print('Http error code : $statusCode');
                    EasyLoading.showToast(statusCode);
                  }).then((data) {
                    EasyLoading.dismiss();
                    print('Http response: $data');

                    if (data != null) {
                      if (data["code"] == 200 || data["code"] == 0) {
                        EasyLoading.showToast("请去邮箱查看密码");
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
