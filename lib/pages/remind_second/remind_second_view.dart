import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import '../remind_first/remind_first_logic.dart';
import 'remind_second_logic.dart';

class RemindSecondPage extends GetView<RemindSecondLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['24-hour system', 'Clear the alarm clock', 'About us'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 0
            ? Obx(() {
                return Switch(
                    activeTrackColor: Colors.green,
                    value: controller.style24.value,
                    onChanged: (v) async {
                      controller.style24.value = v;
                      controller.update();
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('style', v);
                      RemindFirstLogic firstLogic = Get.put(RemindFirstLogic());
                      firstLogic.getData();
                    });
              })
            : index == 1 ? const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              ) : const Text("1.0.0").paddingOnly(right: 10)
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          break;
        case 1:
          controller.cleanRemindData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _item(0, context),
                _item(1, context),
                _item(2, context)
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd9fff6), Color(0xfff4f4f4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.3])),
    );
  }
}
