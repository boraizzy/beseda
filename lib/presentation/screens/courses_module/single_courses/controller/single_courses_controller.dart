import 'dart:convert';
import 'package:education_app/presentation/screens/home_module/home/model/course_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
class SingleCoursesController extends GetxController{
  late CourseModel data;
  Rx<CourseModel> detail = CourseModel.empty().obs;
  late VideoPlayerController videoPlayerController;
  var isPlaying = false.obs;
  var isFullScreen = false.obs;
  var currentPosition = Duration.zero.obs;
  var videoDuration = Duration.zero.obs;
  Future<void>? initializeVideoPlayerFuture;

  var speedSelection = (-1).obs;
  var audioSelection = (-1).obs;
  var subtitleSelection = (-1).obs;
  @override
  void onInit() {
    super.onInit();
    data=Get.arguments as CourseModel;
    fetchCourseDetail();
  }


  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
  void fetchCourseDetail() async {
    try {
      detail.value = await loadJsonFromAsset<CourseModel>(
        AppJsonPath.singleCoursesDetail,
            (json) => CourseModel.fromRawJson(jsonEncode(json)),
      );

      // Now initialize video player using actual data
      final videoUrl = detail.value.videoUrl.isNotEmpty
          ? detail.value.videoUrl
          : "https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4";

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
        videoDuration.value = videoPlayerController.value.duration;
      });

      videoPlayerController.addListener(() {
        isPlaying.value = videoPlayerController.value.isPlaying;
        currentPosition.value = videoPlayerController.value.position;
      });

    } catch (e) {
      if (kDebugMode) {
        print('Error loading single course detail: $e');
      }
    }
  }
  void togglePlayPause() {
    if (isPlaying.value) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  void toggleFullScreen() {
    if (!isFullScreen.value) {
      // Switch to full screen

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // Exit full screen

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    isFullScreen.value = !isFullScreen.value;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void seekBackward() {
    final currentPosition = videoPlayerController.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    videoPlayerController
        .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void seekForward() {
    final currentPosition = videoPlayerController.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    final videoDuration = videoPlayerController.value.duration;
    videoPlayerController
        .seekTo(newPosition > videoDuration ? videoDuration : newPosition);
  }
}