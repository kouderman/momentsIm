import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/pages/mine/areaevent.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../provider/global_model.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import '../../../ui/orther/city_row.dart';
import 'city_controller.dart';

class CityPage extends StatelessWidget {
  final String province;
  final String country;

  String city;

  CityPage(this.country, this.province);

  _buildItem(BuildContext context, int index, CityController controller) {
    var country = controller.list[index];

    return Obx(
      () => new LabelRow(
        label: country.name,
        isLine: true,
        isRight: controller.select == index,
        onPressed: () {
          print('aa');
          this.city = country.name;
          controller.setCityValue(index);
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    LoggerUtil.e("conun " + country + "," + province);
    Get.lazyPut(() => CityController());
    final controller = Get.find<CityController>();
    controller.getdata(country, province);
    var rWidget = new ComMomButton(
      text: '保存',
      style: TextStyle(color: Colors.white),
      width: 55.0,
      margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
      radius: 4.0,
      onTap: () => save(context, controller),
    );
    return FlutterEasyLoading(
      child: new Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(
          title: '选择城市',
          rightDMActions: [rWidget],
        ),
        body: Container(
          child: Obx(()=>ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) =>
                  _buildItem(context, index, controller)),),
        ),
      ),
    );
  }

  save(BuildContext context, CityController controller) {
    if (controller.select == 65537) {
      showToast(context, '请选择城市');
      return;
    }

    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/gen_settings', data: {
      "country": country,
      "province": province,
      "city": city,
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
          showToast(context, '设置成功');
          final model = Provider.of<GlobalModel>(context, listen: false);
          AppData.respprofile.data.country= country;
          AppData.respprofile.data.province= province;
          AppData.respprofile.data.city= city;

          model.refresh();
          LoggerUtil.e("=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + model.area);

          // SpUtil.saveString("area", country+" "+province+" "+city);

        } else {
          showToast(context, data["message"]);
        }
      }
    });
  }
}
