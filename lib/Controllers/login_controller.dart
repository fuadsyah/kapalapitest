// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Models/users_model.dart';
import 'package:kapalapitest/Views/root_screen.dart';
import 'package:kapalapitest/Widget/widgets.dart';

class LoginController extends GetxController {
  var username = TextEditingController(text: 'Sincere@april.biz').obs;
  var password = TextEditingController(text: 'Gwenborough').obs;
  var isLoading = false.obs;
  var deviceModel = ''.obs;
  var deviceManufacture = ''.obs;
  var deviceOs = ''.obs;
  var isPhysicalDevice = true.obs;
  late Rx<UsersModel> user;

  @override
  void onInit() {
    getDeviceId();
    super.onInit();
  }

  void onValidate() {

    if (username.value.text.isEmpty) {
      Get.showSnackbar(customSnackBar(message: 'Username cannot be empty', isWarning: true));
      return;
    }

    if (password.value.text.isEmpty) {
      Get.showSnackbar(customSnackBar(message: 'Password cannot be empty', isWarning: true));
      return;
    }

    if(deviceModel.value != "4df28588f67085eb/SM-N985F"){
      Get.showSnackbar(customSnackBar(message: 'Device not allowed to login', isWarning: true));
      return;
    }

    onSubmit();
  }

  void getDeviceId() async {
    ///init device info
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    const _androidIdPlugin = AndroidId();

    if(Platform.isAndroid){
      final String? androidId = await _androidIdPlugin.getId();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel.value = '$androidId/${androidInfo.model}';
      deviceManufacture.value = androidInfo.manufacturer;
      deviceOs.value = 'Android ${androidInfo.version.release}';
      isPhysicalDevice.value = androidInfo.isPhysicalDevice;

      print(deviceModel);
      return;
    }

    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceModel.value = '${iosInfo.identifierForVendor}/${iosInfo.model}';
      deviceManufacture.value = 'Apple';
      deviceOs.value = 'Ios ${iosInfo.systemVersion}';
      isPhysicalDevice.value = iosInfo.isPhysicalDevice;
      return;
    }
  }

  void onSubmit() async {
    isLoading.value = true;
    bool hasFindUsername = false;
    bool hasFindPass = false;
    UsersModel? u;

    final Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<UsersModel> data = usersModelFromJson(response.body);

      for (var i in data) {
        ///validate username
        if (i.email.toLowerCase() == username.value.text.toLowerCase()) {
          hasFindUsername = true;
        }

        ///validate password
        if (i.address.city.toLowerCase() == password.value.text.toLowerCase()) {
          hasFindPass = true;
        }

        if ((i.email.toLowerCase() == username.value.text.toLowerCase()) &&
            i.address.city.toLowerCase() == password.value.text.toLowerCase()) u = i;
      }

      if (!hasFindUsername || !hasFindPass) {
        Get.showSnackbar(
            customSnackBar(message: 'incorrect username or password ', isWarning: true));
        return;
      } else {
        user = u!.obs;
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString('user', json.encode(user));
        Get.offAll(() => const RootScreen());
      }
    } else {
      Get.showSnackbar(
          customSnackBar(message: 'Error response : ${response.statusCode}', isWarning: true));
      return;
    }
  }
}
