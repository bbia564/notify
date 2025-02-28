import 'package:get/get.dart';

import 'remind_second_logic.dart';

class RemindSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindSecondLogic());
  }
}
