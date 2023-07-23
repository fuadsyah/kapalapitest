// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Views/Album/album_screen.dart';
import 'package:kapalapitest/Views/Location/location_screen.dart';
import '../../Constant/themes.dart';
import '../Views/Home/home_screen.dart';

class RootScreenController extends GetxController {

  final Rx<PageController> pageController = PageController(keepPage: true).obs;
  var screenList = [const HomeScreen(), const AlbumScreen(), const LocationScreen()];
  var selectedScreen = 'home'.obs;
  var selectedColor = Colors.black54.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    pageController.value.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    pageController.value.dispose();
    super.onClose();
  }

  void onChangeScreen({required type}) {
    switch (type) {
      case ('home'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      case ('album'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      case ('location'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(2, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      default:
        break;
    }
  }

  Color getMenuColor(type) {
    if (selectedScreen.value == type) {
     return  kaBlack;
    } else {
      return Colors.black54;
    }
  }
}
