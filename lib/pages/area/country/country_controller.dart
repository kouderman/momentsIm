import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/httpbean/respcountry.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../httpbean/Country.dart';
import '../../../tools/sp_util.dart';

class CountryController extends GetxController {
  final RxList<Country> list = RxList();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    list.clear();
  }

  void getdata() {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/area', data: {
      "action": "country",
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      Respcountry respcountry = Respcountry.fromJson(data);
      list.clear();
      if (respcountry.data.countryList != null) {
        respcountry.data.countryList.forEach((element) {
          list.add(Country(name:element.name));
        });
      }
      if (data != null) {}
    });
  }
}
