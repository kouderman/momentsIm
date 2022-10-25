import 'package:get/get.dart';

import 'update_pwd_controller.dart';

class Update_pwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Update_pwdController());
  }
}
