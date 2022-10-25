import 'package:dim/commom/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/pages/area/city/city_view.dart';

import '../../../config/const.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/orther/label_row.dart';
import 'provice_controller.dart';

class ProvicePage extends StatelessWidget {
  final String name;

  ProvicePage(this.name);


  _buildItem(BuildContext context, int index, ProviceController controller) {
    var country = controller.list[index];

    return new LabelRow(
      label: country.name,
      isLine: true,
      isRight: true,
      onPressed: () => routePush(new CityPage(name,country.name)),
    );
  }



  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProviceController());
    final controller = Get.find<ProviceController>();
    controller.getdata(name);
    return FlutterEasyLoading(
      child: new Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(
          title: '选择省份',
        ),
        body: Container(
          child: Obx(
                () => ListView.builder(
                itemCount: controller.list.length,
                itemBuilder: (context, index) =>
                    _buildItem(context, index, controller)),
          ),
        ),
      ),
    );
  }
}
