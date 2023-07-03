import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class AudioController extends GetxController {
  bool isRecording = false;
  bool isEnable = false;

  FlutterSoundRecorder? _audioRecorder;

  String pathToAudio =
      '/sdcard/Download/Recording-${DateTime.now().millisecondsSinceEpoch}.wav';

  Future<void> _record() async {
    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    isRecording = true;
    update();

    await _audioRecorder!
        .startRecorder(toFile: pathToAudio, codec: Codec.pcm16WAV);
  }

  get audioRecorder => _audioRecorder!.onProgress;

  get isStopped => _audioRecorder!.isStopped;

  Future<void> _stop() async {
    await _audioRecorder!.stopRecorder();
    print('the audio is recorded in $pathToAudio');
    isRecording = false;
    isEnable = true;
    update();
  }

  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }

  void updateBool() {
    isRecording = !isRecording;
    update();
  }

  void init() async {
    _audioRecorder = FlutterSoundRecorder();

    final permission = await Permission.microphone.request();
    try {
      if (permission != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone Permission Denied');
      }
      await _audioRecorder!.openRecorder();
      _audioRecorder!
          .setSubscriptionDuration(const Duration(milliseconds: 500));
    } on RecordingPermissionException catch (e) {
      print('Recording permission exception: $e');
    }
  }

  void close() {
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    close();
    super.onClose();
  }
}
