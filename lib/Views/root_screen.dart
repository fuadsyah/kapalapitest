// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';
import '../Controllers/root_screen_controller.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RootScreenController rsc = Get.put(RootScreenController());
    return Scaffold(
      body: _body(rsc),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      backgroundColor: primaryColor,
      toolbarHeight: 20,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            ///search collection field
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 10,bottom: 10,right: 25),
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), border: Border.all(color: kaGold)),
                child: const TextField(
                  showCursor: false,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      suffixIcon: Icon(CupertinoIcons.search_circle),
                      suffixIconConstraints: BoxConstraints.tightFor(width: 50),
                      hintText: 'Search something',
                      hintStyle: TextStyle(fontSize: 13)),
                ),
              ),
            ),

            ///notification
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(CupertinoIcons.bell, color: kaBlack),
            )
          ],
        ),
      ),
      // title: ,
    );
  }

  Widget _body(RootScreenController rsc) {
    return Stack(
      children: [
        Obx(
          () => PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: rsc.pageController.value,
              children: rsc.screenList),
        ),

        Positioned(top: 0, left: 0, right: 0, child: _appBar()),

        ///floating bottom navigation bar
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 0),
              )
            ], color: primaryColor, borderRadius: BorderRadius.circular(50)),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///movies
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'home'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.home, color: rsc.getMenuColor('home')),
                          Text('Home', style: TextStyle(color: rsc.getMenuColor('home'))),
                        ],
                      ),
                    ),

                    ///television
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'album'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.photo_fill_on_rectangle_fill, color: rsc.getMenuColor('album')),
                          Text('Album', style: TextStyle(color: rsc.getMenuColor('album'))),
                        ],
                      ),
                    ),

                    ///Profile
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'location'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.location, color: rsc.getMenuColor('location')),
                          Text('Location', style: TextStyle(color: rsc.getMenuColor('location'))),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}
