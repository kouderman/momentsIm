import 'package:get/get.dart';

import 'circleindex_controller.dart';

class CircleindexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CircleindexController());
  }
}
