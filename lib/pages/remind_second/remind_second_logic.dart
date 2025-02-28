import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remind_clock/db_remind/db_remind.dart';
import 'package:remind_clock/pages/remind_first/remind_first_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemindSecondLogic extends GetxController {

  DBRemind dbRemind = Get.find();

  var style24 = true.obs;

  cleanRemindData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbRemind.cleanRemindData();
            RemindFirstLogic firstLogic = Get.put(RemindFirstLogic());
            firstLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutRemindUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 78,
        height: 78,
      ),
      children: [
        const Text(
            """We can provide you with a custom alarm clock"""),
      ],
      context: context,
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    style24.value = prefs.getBool('style') ?? true;
    super.onInit();
  }

}
