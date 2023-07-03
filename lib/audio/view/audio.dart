import 'package:camera_test_flutter/audio/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:camera_test_flutter/audio/controller/audio_controller.dart';

class AudioView extends StatelessWidget {
  final PlayerController playerController = Get.find();
  AudioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: GetBuilder<AudioController>(
        builder: (controller) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<RecordingDisposition>(
                    stream: controller.audioRecorder,
                    builder: (context, snapshot) {
                      final duration = snapshot.hasData
                          ? snapshot.data!.duration
                          : Duration.zero;

                      String twoDigits(int n) => n.toString().padLeft(2, '0');

                      final minutes = twoDigits(duration.inMinutes);
                      final seconds =
                          twoDigits(duration.inSeconds.remainder(60));

                      return Text(
                        '$minutes:$seconds',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          controller.isRecording ? Colors.red : Colors.white,
                      foregroundColor:
                          controller.isRecording ? Colors.white : Colors.black,
                    ),
                    onPressed: () async => await controller.toggleRecording(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(controller.isRecording ? Icons.stop : Icons.mic),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(controller.isRecording ? 'STOP' : 'START')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // controller.isEnable ?
                  Obx(
                    () {
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            playerController.isPlaying.value
                                ? TextButton(
                                    onPressed: () => playerController.stop(),
                                    child: const Text(
                                      'Stop',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () => playerController.play(),
                                    child: const Text('Play'),
                                  ),
                            !playerController.isPaused.value
                                ? IconButton(
                                    onPressed: () => playerController.pause(),
                                    icon: const Icon(
                                      Icons.pause_circle,
                                      size: 40,
                                    ),
                                  )
                                : Container(),
                            playerController.isPaused.value
                                ? IconButton(
                                    onPressed: () => playerController.resume(),
                                    icon: const Icon(
                                      Icons.play_circle,
                                      size: 40,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  )
                  // : Container()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
