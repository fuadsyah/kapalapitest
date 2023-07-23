// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';

class HomeController extends GetxController {
  var user;
  var isLoading = true.obs;
  RxList<TableRow> tableRow = <TableRow>[].obs;

  @override
  void onInit() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var u = json.decode(sp.getString('user')!);
    user = u;

    generateTableRow();

    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);


    super.onInit();
  }

  void generateTableRow() {
    user.forEach((key, value) {
      tableRow.add(TableRow(children: [
        Text('$key', style: const TextStyle(color: kaBlack)),
        Text('$value', style: const TextStyle(color: kaBlack)),
      ]));

      tableRow.add(
        ///sized box
        const TableRow(children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      );
    });
  }
}
