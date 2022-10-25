import 'package:dim/commom/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/pages/area/provice/provice_view.dart';

import '../../../config/const.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/orther/label_row.dart';
import '../../mine/change_sex_page.dart';
import 'country_controller.dart';

class CountryPage extends StatelessWidget {
  _buildItem(BuildContext context, int index, CountryController controller) {
    var country = controller.list[index];

    return new LabelRow(
      label: country.name,
      isLine: true,
      isRight: true,
      onPressed: () => routePush(new ProvicePage(country.name)),
    );
  }
  Future<bool> _requestPop(BuildContext c) {//这里是回调函数
    print("POP");
    if (Navigator.canPop(c)) {
      Navigator.pop(c, true);
    } else {
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CountryController());
    final controller = Get.find<CountryController>();
    controller.getdata();
    return FlutterEasyLoading(
      child: WillPopScope(

        child: new Scaffold(
          backgroundColor: appBarColor,
          appBar: new ComMomBar(
            leadingW: IconButton(
              icon: Icon(CupertinoIcons.back,color: Colors.black,),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title: '选择国家',
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
      ),
    );
  }
}
