// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:kapalapitest/Models/users_model.dart';

class LocationController extends GetxController {
  var isLoading = false.obs;

  Rx<Completer<GoogleMapController>> controller = Completer<GoogleMapController>().obs;

  Rx<CameraPosition> kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;

  Future<void> goToLocation(double lat, double lon) async {
    try {
      CameraPosition position = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(lat, lon),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);

      final GoogleMapController c = await controller.value.future;
      await c.animateCamera(CameraUpdate.newCameraPosition(position));
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    isLoading.value = true;

    SharedPreferences sp = await SharedPreferences.getInstance();
    var data = UsersModel.fromJson(json.decode(sp.getString('user')!));

    Future.delayed(
        const Duration(seconds: 1),
        () async => await goToLocation(
            double.parse(data.address.geo.lat), double.parse(data.address.geo.lng)));

    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
    super.onInit();
  }
}
