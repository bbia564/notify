import 'dart:convert';
import 'package:dartx/dartx.dart';

class RemindEntity {
  int id;
  DateTime createdTime;
  DateTime clockTime;
  String mark;
  int isOn;
  List<int> list;

  RemindEntity({
    required this.id,
    required this.createdTime,
    required this.clockTime,
    required this.mark,
    required this.isOn,
    required this.list,
  });

  factory RemindEntity.fromJson(Map<String, dynamic> json) {
    return RemindEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      clockTime: DateTime.parse(json['clockTime']),
      mark: json['mark'],
      isOn: json['isOn'],
      list: (jsonDecode(json['list']) as List)
          .map((e) => e as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'clockTime': clockTime.toIso8601String(),
      'mark': mark,
      'isOn': isOn,
      'list': jsonEncode(list),
    };
  }

  String get clockRemindTime {
    final allClock = [1,2,3,4,5,6,7];
    final workClock = [1,2,3,4,5];
    final weekClock = [6,7];
    if (list.contentEquals(allClock)) {
      return 'Everyday';
    } else if (list.contentEquals(workClock)) {
      return 'Working day';
    } else if (list.contentEquals(weekClock)) {
      return 'Weekend';
    }
    return 'Week ${list.join(',')}';
  }
}