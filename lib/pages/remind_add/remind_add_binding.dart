import 'package:get/get.dart';

import 'remind_add_logic.dart';

class RemindAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindAddLogic());
  }
}
