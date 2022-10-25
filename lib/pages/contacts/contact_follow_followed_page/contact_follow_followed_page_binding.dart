import 'package:get/get.dart';

import 'contact_follow_followed_page_controller.dart';

class Contact_follow_followed_pageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Contact_follow_followed_pageController());
  }
}
