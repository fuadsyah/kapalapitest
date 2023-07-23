// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Constant/themes.dart';
import 'package:kapalapitest/Controllers/home_controller.dart';
import 'package:kapalapitest/Widget/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController hc = Get.put(HomeController());
    return Obx(()=> Scaffold(

      backgroundColor: primaryColor,
      body: hc.isLoading.value ? Center(child: loadingIndicator()) : _body(hc),
    ));
  }

  Widget _body(HomeController hc) {
    return Padding(
      padding: const EdgeInsets.only(top: 110, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Obx(() => Table(
          children: hc.tableRow,
            )),
      ),
    );
  }
}
