import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/imagepicker.dart';

class PickImage extends GetxController {
  Uint8List? image;

  pickmyImage() async {
    try {
      final tempImage = await pickImage(ImageSource.gallery);

      if (tempImage == null) {
        return;
      }

      image = tempImage;

      update();
    } catch (e) {
      Get.snackbar("Message", e.toString());
    }
  }

  // CLEAR - THE - IMAGE
  clear() {
    image = null;
    update();
  }
}
