import 'dart:convert';
import 'package:education_app/presentation/screens/home_module/home/model/course_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';

class CourseDetailController extends GetxController {
  late CourseModel course;
  Rx<CourseModel> detail = CourseModel
      .empty()
      .obs;
  var showAllReviews = false.obs;
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
    course = Get.arguments as CourseModel;

    // 🟢 Дефолтно видео още в началото
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
    );

    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoDuration.value = videoPlayerController.value.duration;
    });

    videoPlayerController.addListener(() {
      isPlaying.value = videoPlayerController.value.isPlaying;
      currentPosition.value = videoPlayerController.value.position;
    });

    // 🟢 След това зареждаме детайлите и евентуално сменяме видеото
    fetchCourseDetail();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
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
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
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
    videoPlayerController.seekTo(
        newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void seekForward() {
    final currentPosition = videoPlayerController.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    final duration = videoPlayerController.value.duration;
    videoPlayerController.seekTo(
        newPosition > duration ? duration : newPosition);
  }

  void fetchCourseDetail() async {
    try {
      detail.value = await loadJsonFromAsset<CourseModel>(
        AppJsonPath.courseDetail,
            (json) => CourseModel.fromRawJson(jsonEncode(json)),
      );


      // 🟢 Ако JSON има видео → презареждаме контролера с него
      if (detail.value.videoUrl.isNotEmpty) {
        videoPlayerController.dispose();
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(detail.value.videoUrl),
        );

        initializeVideoPlayerFuture =
            videoPlayerController.initialize().then((_) {
              videoDuration.value = videoPlayerController.value.duration;
            });

        videoPlayerController.addListener(() {
          isPlaying.value = videoPlayerController.value.isPlaying;
          currentPosition.value = videoPlayerController.value.position;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading course detail: $e');
      }
    }
  }
}
