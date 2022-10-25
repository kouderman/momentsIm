import 'package:get/get.dart';

import 'active_account_controller.dart';

class Active_accountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Active_accountController());
  }
}
