import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/httpbean/city.dart';
import 'package:wechat_flutter/httpbean/respcity.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../config/logger_util.dart';
import '../../../http/Method.dart';
import '../../../httpbean/Country.dart';
import '../../../tools/sp_util.dart';

class CityController extends GetxController {
  final RxList<City> list = RxList();
  final RxInt _select = 65537.obs;

  get select =>_select.value;

  setCityValue(int posi){
    _select.value = posi;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void getdata(String country,String province) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/area', data: {
      "action": "city",
      "country": country,
      "province": province,
      "session_id": authToken,
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      Respcity respcountry = Respcity.fromJson(data);
      list.clear();
      if (respcountry.data.cityList != null) {
        respcountry.data.cityList.forEach((element) {

          if(element.name!=''){
            list.add(City(name:element.name));
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
