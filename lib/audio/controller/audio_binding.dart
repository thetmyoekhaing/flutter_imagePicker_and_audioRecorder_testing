import 'package:camera_test_flutter/audio/controller/audio_controller.dart';
import 'package:camera_test_flutter/audio/controller/player_controller.dart';
import 'package:get/get.dart';

class AudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudioController());
    Get.lazyPut(() => PlayerController());
  }
}
