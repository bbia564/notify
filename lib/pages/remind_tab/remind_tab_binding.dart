import 'package:get/get.dart';

import '../remind_first/remind_first_logic.dart';
import '../remind_second/remind_second_logic.dart';
import 'remind_tab_logic.dart';

class RemindTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindTabLogic());
    Get.lazyPut(() => RemindFirstLogic());
    Get.lazyPut(() => RemindSecondLogic());
  }
}
