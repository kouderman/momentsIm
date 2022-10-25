import 'package:get/get.dart';

import 'childrecye_logic.dart';

class ChildrecyeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChildrecyeLogic());
  }
}
