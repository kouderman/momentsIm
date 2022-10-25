import 'package:get/get.dart';

import 'provice_controller.dart';

class ProviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProviceController());
  }
}
