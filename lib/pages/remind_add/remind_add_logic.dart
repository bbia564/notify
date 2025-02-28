
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remind_clock/db_remind/db_remind.dart';

import '../../db_remind/remind_entity.dart';

class RemindAddLogic extends GetxController {
  DBRemind dbRemind = Get.find();

  DateTime currentTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
  String mark = '';
  List<int> selectedList = [];

  void addData() async {
    if (mark.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the reminder content');
      return;
    }
    if (selectedList.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select at least one day');
      return;
    }
    await dbRemind.insertRemind(RemindEntity(
      id: 0,
      createdTime: DateTime.now(),
      clockTime: currentTime,
      mark: mark,
      isOn: 1,
      list: selectedList,
    ));
    Fluttertoast.showToast(msg: 'Add success');
    Get.back();
  }
}
