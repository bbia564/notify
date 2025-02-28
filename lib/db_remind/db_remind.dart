import 'dart:convert';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:remind_clock/db_remind/remind_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBRemind extends GetxService {
  late Database dbBase;

  Future<DBRemind> init() async {
    await createRemindDB();
    return this;
  }

  createRemindDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'remind.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createRemindTable(db);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('style', true);
    });
  }

  createRemindTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS remind (id INTEGER PRIMARY KEY, createdTime TEXT, clockTime TEXT, mark TEXT, isOn INTEGER, list TEXT)');
  }

  insertRemind(RemindEntity entity) async {
    final id = await dbBase.insert('remind', {
      'createdTime': entity.createdTime.toIso8601String(),
      'clockTime': entity.clockTime.toIso8601String(),
      'mark': entity.mark,
      'isOn': entity.isOn,
      'list': jsonEncode(entity.list)
    });
    return id;
  }

  updateRemind(RemindEntity entity) async {
    await dbBase.update('remind', {
      'createdTime': entity.createdTime.toIso8601String(),
      'clockTime': entity.clockTime.toIso8601String(),
      'mark': entity.mark,
      'isOn': entity.isOn,
      'list': jsonEncode(entity.list)
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  cleanRemindData() async {
    await dbBase.delete('remind');
  }

  Future<List<RemindEntity>> getRemindAllData() async {
    var result = await dbBase.query('remind', orderBy: 'createdTime DESC');
    final here = result.map((e) => RemindEntity.fromJson(e)).toList();
    here.sort((a, b) {
      if (a.clockTime.hour != b.clockTime.hour) {
        return a.clockTime.hour.compareTo(b.clockTime.hour);
      } else {
        return a.clockTime.minute.compareTo(b.clockTime.minute);
      }
    });
    return here;
  }
}
