import 'package:get/get.dart';

import 'tabcircle_view_controller.dart';

class Tabcircle_viewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Tabcircle_viewController());
  }
}
