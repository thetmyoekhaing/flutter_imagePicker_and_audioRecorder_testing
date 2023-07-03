import 'package:camera_test_flutter/image/controller/image_controller.dart';
import 'package:get/get.dart';

class ImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageController());
  }
}
