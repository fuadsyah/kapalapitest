// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../Views/Auth/login_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    goHome();
    super.onInit();
  }

  void goHome() {
    Future.delayed(const Duration(seconds: 3), () => Get.offAll(const LoginScreen()));
  }
}
