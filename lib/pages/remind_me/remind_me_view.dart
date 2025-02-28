import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'remind_me_logic.dart';

class RemindMeView extends GetView<PageLogic> {
  const RemindMeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.johnston.value
              ? const CircularProgressIndicator(color: Colors.teal)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.smpblj();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
