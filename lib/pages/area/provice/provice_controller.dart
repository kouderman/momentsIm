import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/httpbean/province.dart';
import 'package:wechat_flutter/httpbean/respprovince.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../config/logger_util.dart';
import '../../../http/Method.dart';
import '../../../tools/sp_util.dart';

class ProviceController extends GetxController {

  final RxList<Province> list = RxList();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void getdata(String country) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/area', data: {
      "action": "province",
      "country": country,
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      Respprovince respcountry = Respprovince.fromJson(data);
      list.clear();
      if (respcountry.data.provinceList != null) {
        respcountry.data.provinceList.forEach((element) {
          if(element.name!=''){
            list.add(Province(name:element.name));
          }

        });
      }
      if (data != null) {}
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
