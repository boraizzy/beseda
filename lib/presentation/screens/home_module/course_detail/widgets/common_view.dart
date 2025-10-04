import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/alerts/alerts.dart';
import '../../../../common_widgets/common_text_view/home_common_text.dart';
import '../../../../common_widgets/view_common_widget/common_course_view.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../controller/course_detail_controller.dart';

courseHeaderView(BuildContext context) {
  const double horizontalSpacing = 20;
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  CourseDetailController controller = Get.put(CourseDetailController());
  return SingleChildScrollView(
    child: Obx(() {
      final data = controller.detail.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15),
            videoPlayerView(),
            Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonText.semiBold(
                    "AI за начинаещи",
                    size: 16,
                    height: 1.0,
                    letterSpacing: 0.0,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: SvgImageFromAsset(
                    AppCommonIcon.starIcon,
                    height: 12,
                    width: 12,
                  ),
                ),
                Gap(3),
                CommonText.semiBold(
                  data.rate.toString(),
                  size: 12,
                  color: AppColors.secondary500,
                ),
              ],
            ),
            Gap(15),
            CommonText.regular(
              "Този курс „AI за начинаещи“ ще ви въведе в основните концепции на изкуствения интелект. Ще научите какво представлява AI, откъде е тръгнал, какви задачи решава и как се различава тесният от общия интелект. С фокус върху практическото разбиране, курсът е подходящ за всеки, който иска да започне своето пътешествие в света на изкуствения интелект.",
              size: 14,
              color: isDarkMode
                  ? AppColors.bodyTextDarkColor
                  : AppColors.bodyTextColor,
              textAlign: TextAlign.start,
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgImageFromAsset(
                  CommonImageAssets.languageImg,
                  colorFilter: ColorFilter.mode(
                    isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(5),
                CommonText.regular(
                  'English',
                  size: 14,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgImageFromAsset(
                  CommonImageAssets.infoImg,
                  colorFilter: ColorFilter.mode(
                    isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(5),
                CommonText.regular(
                  'Created ${data.date}',
                  size: 14,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Gap(15),
            CommonText.semiBold(
              '\$${data.courseFees}',
              size: 20,
              color: AppColors.primary500,
            ),
            Gap(15),
            PrimaryButton(onPressed: () {
              Get.toNamed(AppRouteName.courseCheckoutView,arguments: data);
            }, label: CourseDetailStrings.buyNow),
            Gap(15),
            Row(
              children: [
                Expanded(
                  child: OutlineButton(
                    onPressed: () {
                      showSuccessMessage(
                        context: context,
                        title: CourseCartStrings.itemAddedSuccessfully,
                        content: '',
                      );
                    },
                    label: CourseDetailStrings.addToWatchList,
                    borderRadius: 6,
                    borderSide: BorderSide(
                      color: AppColors.primary500,
                      width: 1,
                    ),
                    textSize: 16,
                    textColor: AppColors.primary500,
                    textWeight: FontWeight.w500,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      Get.toNamed(AppRouteName.courseCartView);
                    },
                    label: CourseDetailStrings.viewCart,
                    suffixIcon: SvgImageFromAsset(AppCommonIcon.cartIcon),
                  ),
                ),
              ],
            ),
            Gap(15),
            CommonText.semiBold(CourseDetailStrings.learningOutComes, size: 16),
            Gap(15),
            ListView.builder(
              itemCount: data.courseOutComesList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonCacheImage(
                        data.courseOutComesList[index].image,
                        ImagePlaceHolder.imagePlaceHolderDark,
                        fit: BoxFit.cover,
                        height: 18,
                        width: 18,
                      ),
                      Gap(10),
                      Expanded(
                        child: CommonText.regular(
                          data.courseOutComesList[index].title,
                          size: 15,
                          color: isDarkMode
                              ? AppColors.bodyTextDarkColor
                              : AppColors.bodyTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Gap(15)
          ],
        ),
      );
    }),
  );
}

Widget videoPlayerView() {
  CourseDetailController controller = Get.put(CourseDetailController());
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
                                    .videoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(
                                  controller.videoPlayerController!,

                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: commonCacheImage(
                                  "assets/images/ai_course.jpg",
                                  ImagePlaceHolder.imagePlaceHolderDark,
                                  fit: BoxFit.cover,
                                  height: videoPlayerHeight,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    SharePlus.instance.share(
                                      ShareParams(text:   controller.detail.value.name,),
                                    );
                                  },
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
                            controller.videoPlayerController!,
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

Widget courseBottomView() {
  const double horizontalSpacing = 20;
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  CourseDetailController controller = Get.put(CourseDetailController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: CommonText.semiBold(CourseDetailStrings.courseFeature, size: 16),
      ),
      Gap(15),
      ListView.builder(
        itemCount: controller.detail.value.courseFeatureList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        itemBuilder: (context, index) {
          final data = controller.detail.value.courseFeatureList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                commonCacheImage(
                  data.image,
                  ImagePlaceHolder.imagePlaceHolderDark,
                  fit: BoxFit.cover,
                  height: 20,
                  width: 20,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                ),
                Gap(7),
                CommonText.regular(
                  CourseDetailStrings.courseFeature,
                  size: 15,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                ),
              ],
            ),
          );
        },
      ),
      Gap(20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: CommonText.semiBold(CourseDetailStrings.requirements, size: 16),
      ),
      Gap(15),
      ListView.builder(
        itemCount: controller.detail.value.requirements.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 1.5,
                    backgroundColor: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: CommonText.regular(
                    controller.detail.value.requirements[index],
                    size: 14,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      Gap(20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: CommonText.semiBold(CourseDetailStrings.instructor, size: 16),
      ),
      Gap(15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            commonCacheImage(
              controller.detail.value.instructorProfileImg,
              ImagePlaceHolder.imagePlaceHolderDark,
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                  controller.detail.value.instructorName,
                  size: 16,
                ),
                CommonText.regular(
                  controller.detail.value.qualification,
                  size: 14,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                ),
                CommonText.regular(
                  '${controller.detail.value.noOfStudents.toString()} Students',
                  size: 14,
                  color: isDarkMode
                      ? AppColors.greyTextDarkColor
                      : AppColors.greyTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
      Gap(25),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: commonSeeAllText(
          CourseDetailStrings.youMayAlsoLike,

          false,
          () {},
        ),
      ),
      Gap(15),
      Obx(
        () => SizedBox(
          height: 225,
          child: ListView.builder(
            itemCount: controller.detail.value.courseList.length,
            shrinkWrap: true,

            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
            itemBuilder: (context, index) {
              final data = controller.detail.value.courseList[index];
              return InkWell(
                onTap: () {},
                child:  CommonCourseView(width: 220, data: data),
              );
            },
          ),
        ),
      ),
    ],
  );
}
