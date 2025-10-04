import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../../home_module/home/model/course_model.dart';
import '../controller/my_progress_controller.dart';
import '../model/achievement_model.dart';

Widget commonContainer({required double height, required String title}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: AppColors.primary500,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(33),
        topRight: Radius.circular(33),
      ),
        border: Border.all(color: AppColors.primary100)
    ),
    child: Center(
      child: CommonText.semiBold(title, size: 44, color: AppColors.white),
    ),
  );
}

Widget commonView({
  required String image,
  required String name,
  required String courses,
}) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Column(
    children: [
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: isDarkMode?AppColors.greyDarkColor:AppColors.background100,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: commonCacheImage(
            image,
            ImagePlaceHolder.imagePlaceHolderDark,
            height: 32,
            width: 32,
          ),
        ),
      ),
      Gap(10),
      CommonText.medium(name, size: 15),
      Gap(10),
      Container(
        height: 28,
        width: 96,

        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(27.6),

        ),
        child: Center(
          child: CommonText.medium(courses, size: 12, color: AppColors.white),
        ),
      ),
    ],
  );
}

Widget courseListView(CourseModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: BoxDecoration(
      color: isDarkMode?AppColors.cardDarkBgColor:AppColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: isDarkMode?AppColors.grey100Color:Colors.transparent)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonText.semiBold(data.id.toString(), size: 14),
        Gap(15),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: isDarkMode?AppColors.greyDarkColor:AppColors.cardBgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: commonCacheImage(
              data.image,
              ImagePlaceHolder.imagePlaceHolderDark,
              fit: BoxFit.cover,
              height: 24,
              width: 24,
            ),
          ),
        ),
        Gap(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.semiBold(data.name, size: 15),
            CommonText.medium(
              '${data.coursesNo.toString()} courses',
              size: 14,
              color: AppColors.greyTextColor,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget ongoingCourseListView(CourseModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    decoration: isDarkMode
        ? AppCommonShadow.commonDarkBoxShadow
        : AppCommonShadow.commonBoxShadow,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonCacheImage(
          data.image,
          ImagePlaceHolder.imagePlaceHolderDark,
          fit: BoxFit.cover,
          height: 110,
        ),
        Gap(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText.medium(
                data.name,
                size: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(10),

              commonText(MyProgressString.startDate, data.date),
              Gap(3),
              commonText(
                MyProgressString.totalLec,
                data.noOfLectures.toString(),
              ),
              Gap(3),

              commonText(
                MyProgressString.completedLec,
                data.noOfCompletedLectures.toString(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget achievementView(AchievementModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
          color: AppColors.secondary40,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: commonCacheImage(
            data.image,
            ImagePlaceHolder.imagePlaceHolderDark,
            fit: BoxFit.cover,
            height: 44,
            width: 44,
          ),
        ),
      ),
      Gap(15),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.semiBold(data.name, size: 16),
            Gap(10),
            CommonText.regular(
              data.description,
              size: 12,
              color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
            ),
          ],
        ),
      ),
    ],
  );
}

commonText(String title, String subtitle) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 90,

        child: CommonText.medium(
          '$title:',
          size: 12,
          color:isDarkMode?AppColors.greyTextDarkColor: AppColors.greyTextColor,
        ),
      ),
      Expanded(child: CommonText.medium(subtitle, size: 12)),
    ],
  );
}

commonEarnedPoints(String title, String subtitle) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText.medium(title, size: 14, color:isDarkMode?AppColors.bodyTextDarkColor: AppColors.bodyTextColor),
      Gap(10),
      CommonText.semiBold(subtitle, size: 18),
    ],
  );
}

pointsEarnedView() {
  MyProgressController controller = Get.put(MyProgressController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Obx(
    () =>  Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDarkMode?AppColors.greyDarkColor:AppColors.cardBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonEarnedPoints(
            MyProgressString.totalPoints,
            controller.detail.value.totalPoints.toString(),
          ),
          commonEarnedPoints(
            MyProgressString.balancedPoints,
            controller.detail.value.balancedPoints.toString(),
          ),
          commonEarnedPoints(
            MyProgressString.usedPoints,
            controller.detail.value.usedPoints.toString(),
          ),
        ],
      ),
    ),
  );
}
