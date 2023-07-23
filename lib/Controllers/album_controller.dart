// 📦 Package imports:
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:kapalapitest/Models/album_model.dart';
import '../Widget/snack_bar.dart';

class AlbumController extends GetxController {
  late RxList<AlbumModel> album;
  var isLoading = false.obs;
  var albumCategory = [].obs;

  @override
  void onInit() {
    onGetAlbum();
    super.onInit();
  }

  Future<void> onGetAlbum() async {
    isLoading.value = true;
    final Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var response = await http.get(uri);

    ///close loading
    isLoading.value = false;

    if (response.statusCode == 200) {
      album = albumModelFromJson(response.body).obs;

      getAlbumCategory();
    } else {
      Get.showSnackbar(
          customSnackBar(message: 'Error response : ${response.statusCode}', isWarning: true));
      return;
    }
  }

  void getAlbumCategory() {
    var a = [];
    for (var e in album) {
      a.add(e.albumId);
    }
    albumCategory.assignAll(a.toSet());
  }
}
