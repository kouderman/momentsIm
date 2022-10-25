import 'package:get/get.dart';

import 'country_controller.dart';

class CountryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryController());
  }
}
