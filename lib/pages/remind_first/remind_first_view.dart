import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import 'remind_first_logic.dart';

class RemindFirstPage extends GetView<RemindFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<RemindFirstLogic>(init: RemindFirstLogic(),builder: (_) {
          return SafeArea(
              child: controller.list.isEmpty
                  ? const Center(
                      child: Text('No data'),
                    )
                  : <Widget>[
                      const Text(
                        'Last alarm clock',
                        textAlign: TextAlign.center,
                      ),
                      Obx(() {
                        return Text(
                          controller.remindStr.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.list.length,
                            itemBuilder: (_, index) {
                              var entity = controller.list[index];
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: <Widget>[
                                  Expanded(
                                      child: <Widget>[
                                    Text(entity.clockRemindTime),
                                    Text(
                                      DateFormat(controller.style24
                                              ? 'HH:mm'
                                              : 'h:mm a')
                                          .format(entity.clockTime),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ).marginSymmetric(vertical: 6),
                                    Text(
                                      entity.mark,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ].toColumn(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start)),
                                  Switch(
                                      activeTrackColor: Colors.green,
                                      value: entity.isOn == 1 ? true : false,
                                      onChanged: (v) async {
                                        entity.isOn = v ? 1 : 0;
                                        await controller.dbRemind
                                            .updateRemind(entity);
                                        controller.getData();
                                      })
                                ].toRow(),
                              )
                                  .decorated(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15))
                                  .marginOnly(bottom: 12);
                            }),
                      )
                    ].toColumn().marginAll(15));
        }),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd9fff6), Color(0xfff4f4f4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.3])),
    );
  }
}
