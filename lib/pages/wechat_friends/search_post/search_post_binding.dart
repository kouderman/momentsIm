import 'package:get/get.dart';

import 'search_post_controller.dart';

class Search_postBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Search_postController());
  }
}
