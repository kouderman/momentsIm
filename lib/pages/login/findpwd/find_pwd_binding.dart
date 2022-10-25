import 'package:get/get.dart';

import 'find_pwd_controller.dart';

class Find_pwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Find_pwdController());
  }
}
