// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Constant/themes.dart';
import 'package:kapalapitest/Controllers/album_controller.dart';
import 'package:kapalapitest/Widget/widgets.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AlbumController ac = Get.put(AlbumController());
    return Obx(() => ac.isLoading.value
        ? Center(child: loadingIndicator())
        : Scaffold(
            body: _body(ac),
          ));
  }

  Widget _body(AlbumController ac) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 70),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              shrinkWrap: true,
              itemCount: ac.albumCategory.length,
              itemBuilder: (c, i) {
                ///get image url
                var imageUrl = ac.album.where((p0) => p0.albumId == ac.albumCategory[i]).first;

                return Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: imageFromNetwork(url: imageUrl.thumbnailUrl)),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [primaryColor, kaGold],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp)),
                        child: Text('Category ${ac.albumCategory[i]}'),
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}
