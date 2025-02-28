import 'package:get/get.dart';

import 'remind_first_logic.dart';

class RemindFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindFirstLogic());
  }
}
