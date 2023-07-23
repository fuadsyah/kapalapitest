// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart ';

// 🌎 Project imports:
import 'package:kapalapitest/Widget/loading_indicator.dart';
import '../../Constant/themes.dart';
import '../../Controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController lc = Get.put(LoginController());
    return Scaffold(
      body: _body(lc),
    );
  }

  Widget _body(LoginController lc) {
    return Stack(
      children: [
        //background color
        Positioned(bottom: 0, left: 0, right: 0, top: 0, child: backGround()),

        Positioned(top: -0, right: -40, child: _hand1()),

        Positioned(left: -20, top: 0, child: _hand2()),

        Positioned(left: 0, bottom: 0, top: 0, right: 0, child: _buildLoginForm(lc)),
      ],
    );
  }

  Widget backGround() {
    return Container(
      decoration: const BoxDecoration(
        gradient: SweepGradient(
          center: Alignment(0.20, -0.15),
          startAngle: 2 * math.pi / 2,
          endAngle: 5 * math.pi / 2,
          tileMode: TileMode.mirror,
          colors: <Color>[
            loadScreenColor1,
            loadScreenColor2,
            primaryColor,
          ],
          stops: <double>[0.1, 0.65, 1.0],
        ),
      ),
    );
  }

  Widget _hand1() {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(
          -3.8 / 4,
        ),
        child: Image.asset(
          'assets/images/handbagging.png',
          width: 200,
        ));
  }

  Widget _hand2() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        3.8 / 4,
      ),
      child: Image.asset(
        'assets/images/handmaking.png',
        width: 120,
      ),
    );
  }

  Widget _buildLoginForm(LoginController lc) {
    return SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 178, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lets',
                style: TextStyle(fontSize: 36, color: kaGold),
              ),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 36, color: kaBlack, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 73),
              _userName(lc),
              const SizedBox(height: 25),
              _passwordForm(lc),
              const SizedBox(height: 40),
              _submitButton(lc),
              const SizedBox(height: 20),
              _deviceIdText(lc),
            ],
          ),
        ));
  }

  Widget _userName(LoginController lc) {
    return Obx(
      () => SizedBox(
        height: 40,
        child: TextField(
          style: const TextStyle(color: kaBlack, fontSize: 16),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 1,
                color: kaGold,
                style: BorderStyle.solid,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            filled: true,
            contentPadding: const EdgeInsets.only(left: 22, top: 10, bottom: 11),
            hintStyle: const TextStyle(color: kaGold, fontSize: 16),
            hintText: "User Name",
            fillColor: primaryColor,
          ),
          textInputAction: TextInputAction.next,
          controller: lc.username.value,
        ),
      ),
    );
  }

  Widget _passwordForm(LoginController lc) {
    return ObxValue(
      (RxBool obscure) => SizedBox(
        height: 40,
        child: TextField(
          obscureText: obscure.value,
          style: const TextStyle(color: kaBlack, fontSize: 16),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 1,
                  color: kaGold,
                  style: BorderStyle.solid,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    obscure.value == true ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: kaBlack,
                  ),
                  onPressed: () => obscure.value = !obscure.value),
              filled: true,
              contentPadding: const EdgeInsets.only(left: 22, top: 10, bottom: 11),
              hintStyle: const TextStyle(color: kaGold, fontSize: 16),
              hintText: "Password",
              fillColor: primaryColor),
          textInputAction: TextInputAction.go,
          controller: lc.password.value,
          onSubmitted: (_) {
            lc.onSubmit();
          },
        ),
      ),
      true.obs,
    );
  }

  Widget _submitButton(LoginController lc) {
    return Center(
      child: Obx(() => lc.isLoading.value
          ? loadingIndicator()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kaGold,
                minimumSize: const Size(312, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () => lc.onValidate(),
              child: const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.w400),
              ))),
    );
  }

  Widget _deviceIdText(LoginController lc) {
    return Obx(
      () => Center(
        child: Text(
          '${lc.deviceModel}',
          style: const TextStyle(color: kaBlack),
        ),
      ),
    );
  }
}
