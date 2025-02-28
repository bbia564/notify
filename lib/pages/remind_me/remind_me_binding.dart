import 'package:get/get.dart';

import 'remind_me_logic.dart';

class RemindMeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
