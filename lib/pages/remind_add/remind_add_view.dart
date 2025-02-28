import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:remind_clock/main.dart';
import 'package:remind_clock/pages/remind_add/remind_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import 'remind_add_logic.dart';

class RemindAddPage extends GetView<RemindAddLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add clock'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<RemindAddLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
                  SizedBox(
                    height: 260,
                    child: DateTimePickerWidget(
                      initDateTime: controller.currentTime,
                      dateFormat: 'HH:mm',
                      pickerTheme: const DateTimePickerTheme(
                          cancel: null,
                          confirm: null,
                          showTitle: false,
                          title: null),
                      onChange: (dateTime, List<int> index) {
                        controller.currentTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            dateTime.hour,
                            dateTime.minute);
                        controller.update();
                      },
                    ),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 40,
                    child: RemindTextField(
                        hintText: 'Reminder content',
                        maxLength: 15,
                        value: controller.mark,
                        onChange: (v) {
                          controller.mark = v;
                        }),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  const Text('Week'),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 36,
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, mainAxisSpacing: 10),
                        itemBuilder: (_, index) {
                          return LayoutBuilder(builder: (_, max) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    color: controller.selectedList
                                            .contains(index + 1)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            )
                                .decorated(
                                    color: controller.selectedList
                                            .contains(index + 1)
                                        ? primaryColor
                                        : const Color(0xffefefef),
                                    borderRadius:
                                        BorderRadius.circular(max.maxWidth / 2))
                                .gestures(onTap: () {
                              if (controller.selectedList.contains(index + 1)) {
                                controller.selectedList.remove(index + 1);
                              } else {
                                controller.selectedList.add(index + 1);
                              }
                              controller.update();
                            });
                          });
                        }),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                      .decorated(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15))
                      .gestures(onTap: () {
                    controller.addData();
                  })
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(20))
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
