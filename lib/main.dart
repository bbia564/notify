import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_clock/db_remind/db_remind.dart';
import 'package:remind_clock/pages/no_network/no_network_binding.dart';
import 'package:remind_clock/pages/no_network/no_network_view.dart';
import 'package:remind_clock/pages/remind_add/remind_add_binding.dart';
import 'package:remind_clock/pages/remind_add/remind_add_view.dart';
import 'package:remind_clock/pages/remind_first/remind_first_binding.dart';
import 'package:remind_clock/pages/remind_first/remind_first_view.dart';
import 'package:remind_clock/pages/remind_second/remind_second_binding.dart';
import 'package:remind_clock/pages/remind_second/remind_second_view.dart';
import 'package:remind_clock/pages/remind_tab/remind_tab_binding.dart';
import 'package:remind_clock/pages/remind_tab/remind_tab_view.dart';

Color primaryColor = const Color(0xff32b29e);
Color bgColor = const Color(0xfff4f4f4);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBRemind().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Minds,
      initialRoute: '/remindTab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Minds = [
  GetPage(name: '/remindTab', page: () => RemindTabPage(), binding: RemindTabBinding()),
  GetPage(name: '/remindFirst', page: () => RemindFirstPage(), binding: RemindFirstBinding()),
  GetPage(name: '/remindSecond', page: () => RemindSecondPage(), binding: RemindSecondBinding()),
  GetPage(name: '/remindAdd', page: () => RemindAddPage(), binding: RemindAddBinding()),
  GetPage(name: '/reload',page: () => NoNetworkPage(), binding: NoNetworkBinding())
];