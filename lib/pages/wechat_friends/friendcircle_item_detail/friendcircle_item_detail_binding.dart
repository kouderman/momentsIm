import 'package:get/get.dart';

import 'friendcircle_item_detail_controller.dart';

class Friendcircle_item_detailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Friendcircle_item_detailController());
  }
}
