import 'package:camera_test_flutter/audio/controller/audio_binding.dart';
import 'package:camera_test_flutter/audio/view/audio.dart';
import 'package:camera_test_flutter/home/home.dart';
import 'package:camera_test_flutter/image/controller/image_binding.dart';
import 'package:camera_test_flutter/image/view/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const Home(),
        ),
        GetPage(
          name: '/image',
          page: () => const ImageView(),
          binding: ImageBinding(),
        ),
        GetPage(
          name: '/audio',
          page: () => AudioView(),
          binding: AudioBinding(),
        )
      ],
    );
  }
}
