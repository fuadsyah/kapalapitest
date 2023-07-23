// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Controllers/location_controller.dart';
import 'package:kapalapitest/Widget/loading_indicator.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController lc = Get.put(LocationController());
    return Obx(() => lc.isLoading.value
        ? Center(child: loadingIndicator())
        : Scaffold(
            body: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: lc.kGooglePlex.value,
              onMapCreated: (GoogleMapController controller) {
                lc.controller.value.complete(controller);
              },
            ),
          ));
  }
}
