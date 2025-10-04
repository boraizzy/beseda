import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../../home_module/course_detail/model/course_curriculum_model.dart';
import '../controller/single_courses_controller.dart';

Widget singleVideoPlayerView() {
  SingleCoursesController controller = Get.put(SingleCoursesController());
  return FutureBuilder(
    future: controller.initializeVideoPlayerFuture ?? Future.value(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return SafeArea(
          top: false,
          bottom: false,
          left: false,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double videoPlayerHeight = controller.isFullScreen.value
                      ? MediaQuery.sizeOf(context)
                            .height // Full screen height
                      : 200; // Non-fullscreen height
                  return Obx(() {
                    return controller.isPlaying.value
                        ? SizedBox(
                            width: double.infinity,
                            height: videoPlayerHeight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: AspectRatio(
                                aspectRatio: controller
                                    .videoPlayerController
                                    .value
                                    .aspectRatio,
                                child: VideoPlayer(
                                  controller.videoPlayerController,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: commonCacheImage(
                                  controller.detail.value.image,
                                  ImagePlaceHolder.imagePlaceHolderDark,
                                  fit: BoxFit.cover,
                                  height: videoPlayerHeight,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Center(
                                  child: SvgImageFromAsset(
                                    CommonImageAssets.shareImg,
                                  ),
                                ),
                              ),
                            ],
                          );
                  });
                },
              ),
              Obx(() {
                return controller.isPlaying.value
                    ? const SizedBox()
                    : Positioned(
                        left: 50,
                        child: IconButton(
                          icon: SvgImageFromAsset(AppCommonIcon.rewindBackIcon),
                          onPressed: () {
                            controller.seekBackward();
                          },
                        ),
                      );
              }),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.togglePlayPause();
                  },
                  child: controller.isPlaying.value
                      ? Icon(Icons.pause, color: AppColors.white)
                      : SvgImageFromAsset(
                          AppCommonIcon.btnPlayIcon,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              Obx(() {
                return controller.isPlaying.value
                    ? const SizedBox()
                    : Positioned(
                        right: 50,
                        child: IconButton(
                          icon: SvgImageFromAsset(
                            AppCommonIcon.rewindForwardIcon,
                          ),
                          onPressed: () {
                            controller.seekForward();
                          },
                        ),
                      );
              }),
              Positioned(
                bottom: 25,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VideoProgressIndicator(
                            controller.videoPlayerController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: AppColors.white,
                              bufferedColor: AppColors.white.withValues(
                                alpha: 0.30,
                              ),
                              backgroundColor: AppColors.white.withValues(
                                alpha: 0.30,
                              ),
                            ),
                          ),
                          Gap(12),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText.regular(
                                  controller.formatDuration(
                                    controller.currentPosition.value,
                                  ),
                                  size: 12,
                                  color: AppColors.bodyTextDarkColor,
                                ),
                                CommonText.regular(
                                  controller.formatDuration(
                                    controller.videoDuration.value,
                                  ),
                                  size: 12,
                                  color: AppColors.bodyTextDarkColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(12),
                    InkWell(
                      onTap: () {
                        controller.toggleFullScreen();
                      },
                      child: Icon(Icons.fullscreen_exit, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularProgressIndicator(color: AppColors.primary500),
          ),
        );
      }
    },
  );
}

Widget singleCourseView() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  SingleCoursesController controller = Get.put(SingleCoursesController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommonText.semiBold(
              SingleCoursesStrings.enhanceYourLearning,
              color: AppColors.primary500,
              size: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: SvgImageFromAsset(AppCommonIcon.aiStarIcon),
          ),
        ],
      ),
      Gap(20),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommonText.medium(
              SingleCoursesStrings.summarizeVideo,
              size: 14,
            ),
          ),
          SizedBox(
            width: 111,
            child: PrimaryButton(
              height: 32,
              borderRadius: 4,
              onPressed: () {
                Get.toNamed(AppRouteName.summarizeVideoView);
              },
              label: SingleCoursesStrings.viewSummarise,
              textSize: 12,
            ),
          ),
        ],
      ),
      Gap(18),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommonText.medium(
              SingleCoursesStrings.convertVideo,
              size: 14,
            ),
          ),
          SizedBox(
            width: 111,
            child: PrimaryButton(
              height: 32,
              borderRadius: 4,
              onPressed: () {
                Get.toNamed(AppRouteName.videoToTextView);
              },
              label: SingleCoursesStrings.convert,
              textSize: 12,
            ),
          ),
        ],
      ),
      Obx(
        () => ListView.builder(
          itemCount: controller.detail.value.courseCurriculumList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            final data = controller.detail.value.courseCurriculumList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.cardDarkBgColor
                        : AppColors.cardBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ExpansionTile(
                    collapsedIconColor: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                    iconColor: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                    showTrailingIcon: false,
                    tilePadding: EdgeInsets.symmetric(horizontal: 15),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.medium(
                                data.title,
                                size: 15,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CommonText.semiBold(
                                    '${data.noOfCompletedLectures}/${data.lecturesList.length}',
                                    size: 14,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    color: AppColors.primary500,
                                  ),
                                  Gap(5),
                                  CommonText.medium(
                                    HomeViewStrings.completed,
                                    size: 14,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SvgImageFromAsset(CommonImageAssets.coursePdf),
                        Gap(5),
                        SvgImageFromAsset(AppCommonIcon.arrowDownIcon),
                      ],
                    ),

                    children: [lectureView(data)],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      PrimaryButton(
        onPressed: () {
          Get.toNamed(
            AppRouteName.courseCertificateView,
            arguments: controller.data.name,
          );
        },
        label: SingleCoursesStrings.getCertificate,
      ),
    ],
  );
}

Widget lectureView(CourseCurriculumModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  SingleCoursesController controller = Get.put(SingleCoursesController());
  return Container(
    color: isDarkMode ? AppColors.mainDarkBgColor : AppColors.white,
    child: ListView.builder(
      itemCount: data.lecturesList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final lecture = data.lecturesList[index];
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText.medium(
                '0${lecture.id.toString()}',
                size: 16,
                color: isDarkMode
                    ? AppColors.bodyTextDarkColor
                    : AppColors.bodyTextColor,
              ),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.medium(
                      lecture.name,
                      size: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CommonText.regular(
                      lecture.timeOfVideo,
                      size: 13,
                      color: isDarkMode
                          ? AppColors.greyTextDarkColor
                          : AppColors.greyTextColor,
                    ),
                  ],
                ),
              ),
              Gap(5),
              controller.data.isLiveClasses==true?SizedBox(
                width: 60,
                child: PrimaryButton(
                  height: 27,
                    backgroundColor: AppColors.primary500,
                    onPressed: () {
                    Get.toNamed(AppRouteName.meetingPermissionView,arguments: controller.data.name);


                }, label: SingleCoursesStrings.join),
              ):
              Row(
                children: [
                  SvgImageFromAsset(
                    AppCommonIcon.downloadIcon,
                    colorFilter: ColorFilter.mode(
                      lecture.isDownloaded
                          ? AppColors.success500
                          : isDarkMode?AppColors.white:AppColors.headingsColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gap(15),
                  lecture.isCompleted
                      ? SvgImageFromAsset(AppCommonIcon.checkIcon)
                      : checkIcon(isDarkMode?AppColors.grey100Color:AppColors.greyColor),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget checkIcon(Color color) {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(child: Icon(Icons.check, color: AppColors.white, size: 14)),
  );
}
