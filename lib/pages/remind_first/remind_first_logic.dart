import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remind_clock/db_remind/db_remind.dart';
import 'package:remind_clock/db_remind/remind_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemindFirstLogic extends GetxController {

  DBRemind dbRemind = Get.find();

  var list = <RemindEntity>[];
  var remindStr = ''.obs;
  var style24 = true;

  Timer? _timer;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    style24 = prefs.getBool('style') ?? true;
    list = await dbRemind.getRemindAllData();
    if (list.isNotEmpty) {
      final diff = list.first.clockTime.difference(DateTime.now());
      remindStr.value = '${diff.inHours.abs()} hours ${(diff.inMinutes % 60).abs()} minutes later reminder';
    }
    update();
    startTimer();
  }


  void startTimer() {
    stopTimer();
    var result = list;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      for (var item in result) {
        if (item.clockTime.isBefore(DateTime.now())) {
          item.clockTime = item.clockTime.add(const Duration(days: 1));
          await dbRemind.updateRemind(item);
          getData();
          break;
        }
        if (item.clockTime == DateTime.now() && item.isOn == 1) {
          Fluttertoast.showToast(msg: '${item.mark} is coming');
        }
      }
      if (result.isNotEmpty) {
        final diff = result.first.clockTime.difference(DateTime.now());
        remindStr.value = '${diff.inHours.abs()} hours ${(diff.inMinutes % 60).abs()} minutes later reminder';
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
