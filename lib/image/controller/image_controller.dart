import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageController extends GetxController {
  File? image;
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? img = await ImagePicker().pickImage(source: source);
      if (img == null) return;

      // final tempImg = File(img.path);

      // print('temp image -> $tempImg');

      final permenentImg = await saveImagePermenently(imagePath: img.path);
      print('permenent img -> $permenentImg');

      image = permenentImg;
      update();

      print('updated $image');
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future<File> saveImagePermenently({required String imagePath}) async {
    // save in com.blahblah
    // final dir = await getApplicationDocumentsDirectory();
    // final name = basename(imagePath);
    // final image = File('${dir.path}/$name');

    final dir = await getApplicationDocumentsDirectory();
    final picturesDirectory = Directory('${dir.path}/Pictures');

    if (!picturesDirectory.existsSync()) {
      picturesDirectory.createSync(recursive: true);
    }
    final name = imagePath.split('/').last;
    final image = File('${picturesDirectory.path}/$name');
    print('picture dir --> ${picturesDirectory.toString()}');
    return File(imagePath).copy(image.path);
  }
}
