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
import 'update_pwd_controller.dart';

class Update_pwdPage extends StatelessWidget {


  TextEditingController old = new TextEditingController();
  TextEditingController xin = new TextEditingController();
  TextEditingController xinagain = new TextEditingController();

  bool isEnable() {
    return old.text != '' &&
        xin.text != '' &&
        xinagain.text != '' ;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Update_pwdController());
    final controller = Get.find<Update_pwdController>();
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '修改密码'),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              new EditView(
                label: "原始密码",
                ispassword: true,
                hint: "请输入原始密码",
                controller: old,
                onChanged: (str) {
                },
              ),
              new EditView(
                label: "新密码",
                ispassword: true,
                hint: "请输入新密码",
                controller: xin,
                onChanged: (str) {
                },
              ),
              new EditView(
                label: "确认新密码",
                ispassword: true,
                hint: "请再次输入新密码",
                controller: xinagain,
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
                  if(!isEnable()){
                    EasyLoading.showToast("请输入完整信息");
                    return;
                  }
                  if(xin.text!=xinagain.text){
                    EasyLoading.showToast("新密码不一致");
                    return;
                  }
                  print('aa');
                  String token = SpUtil.getString("authToken") ;
                  EasyLoading.show(status: '加载中...');
                  DioUtil()
                      .post('$baseUrl/change_password', data: {
                    "old_password": old.text,
                    "new_password": xin.text,
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
