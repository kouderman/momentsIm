import 'package:get/get.dart';

import 'friendcircle_controller.dart';

class FriendcircleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendcircleController());
  }
}
