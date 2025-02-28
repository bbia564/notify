import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_clock/pages/remind_add/remind_add_view.dart';
import 'package:remind_clock/pages/remind_first/remind_first_logic.dart';
import 'package:remind_clock/pages/remind_first/remind_first_view.dart';
import 'package:remind_clock/pages/remind_second/remind_second_view.dart';

import '../../main.dart';
import 'remind_tab_logic.dart';

class RemindTabPage extends GetView<RemindTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          RemindFirstPage(),
          RemindAddPage(),
          RemindSecondPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navReBars()),
    );
  }

  Widget _navReBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/item0Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/item0Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,color: primaryColor,size: 40,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item1Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/item1Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          Get.toNamed('/remindAdd')?.then((_) {
            RemindFirstLogic firstLogic = Get.put(RemindFirstLogic());
            firstLogic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}
