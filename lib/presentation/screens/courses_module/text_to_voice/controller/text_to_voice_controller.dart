import 'dart:async';
import 'package:get/get.dart';

class TextToVoiceController extends GetxController {
  late String getText;

  RxBool isPlaying = false.obs;
  RxDouble progress = 0.0.obs;
  RxInt totalDuration = 0.obs; // in seconds
  RxInt currentTime = 0.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    getText = Get.arguments as String;
    estimateDuration();
  }

  void estimateDuration() {
    // Estimate: 150 words per minute = 2.5 words/sec
    int wordCount = getText.trim().split(RegExp(r'\s+')).length;
    totalDuration.value = (wordCount / 2.5).ceil(); // rough estimate in seconds
  }

  void startProgressTimer(Function onCompleted) {
    _timer?.cancel();
    currentTime.value = 0;
    progress.value = 0.0;
    isPlaying.value = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTime.value >= totalDuration.value) {
        stopProgress();
        onCompleted();
      } else {
        currentTime.value++;
        progress.value = currentTime.value / totalDuration.value;
      }
    });
  }

  void stopProgress() {
    _timer?.cancel();
    isPlaying.value = false;
  }

  void resetProgress() {
    stopProgress();
    progress.value = 0.0;
    currentTime.value = 0;
  }
}
