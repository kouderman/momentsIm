import 'package:get/get.dart';

import 'manager_group_member_controller.dart';

class Manager_group_memberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Manager_group_memberController());
  }
}
