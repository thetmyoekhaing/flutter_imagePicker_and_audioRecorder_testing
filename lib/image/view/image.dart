import 'package:camera_test_flutter/image/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Testing'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: GetBuilder<ImageController>(builder: (imgController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imgController.image == null
                  ? const Center(
                      child: FlutterLogo(
                        size: 100,
                      ),
                    )
                  : Center(
                      child: Image.file(
                        imgController.image!,
                        height: 200,
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  onTap: () async =>
                      await imgController.pickImage(ImageSource.gallery),
                  leading: const Icon(Icons.photo_size_select_actual_rounded),
                  title: const Text('Choose From Gallery'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  onTap: () async =>
                      await imgController.pickImage(ImageSource.camera),
                  leading: const Icon(Icons.camera),
                  title: const Text('From Camera'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
