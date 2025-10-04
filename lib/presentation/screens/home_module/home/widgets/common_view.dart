import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../quiz_list/model/quiz_model.dart';
import '../controller/home_controller.dart';
import '../model/course_category.dart';
import '../model/course_model.dart';
import '../model/university_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../model/course_model.dart';

Widget commonAppBar() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.myProfileView);
        },
        child: SvgImageFromAsset(CommonImageAssets.userProfileImg),
      ),
      Spacer(),
      InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.notificationView);
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.backgroundLight : AppColors.white,
            shape: BoxShape.circle,
          ),

          child: Center(
            child: SvgImageFromAsset(CommonImageAssets.notificationImg),
          ),
        ),
      ),
      Gap(12),
      InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.courseCartView);
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.secondary40,
            shape: BoxShape.circle,
          ),
          child: Center(child: SvgImageFromAsset(CommonImageAssets.cartImg)),
        ),
      ),
    ],
  );
}

Widget ongoingCoursesView(CourseModel data) {
  return Container(
    width: 240,
    margin: EdgeInsets.only(right: 18),
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: commonCacheImage(
            data.image,
            ImagePlaceHolder.imagePlaceHolderDark,
            fit: BoxFit.fill,
            height: 157,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.20),

                      //gradient: AppCommonGradient.borderGradient,
                      // boxShadow: [
                      //   BoxShadow(blurRadius: 14),
                      // ],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.75),
                      ),
                    ),
                    child: Center(
                      child: CommonText.semiBold(
                        '${data.percentage.toString()}%',
                        size: 15,

                        color: AppColors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // подаваш course data
                      Get.toNamed(
                        AppRouteName.courseDetailView,
                        arguments: data, // 👈 тук трябва да има инстанция на CourseModel
                      );
                    },
                    child: CommonText.semiBold(
                      HomeViewStrings.viewCourse,
                      size: 12,
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
              Gap(20),
              CommonText.semiBold(
                data.name,
                size: 18,
                color: AppColors.white,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CommonText.semiBold(
                  '${data.noOfCompletedLectures}/${data.noOfLectures}',
                  size: 14,
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              Gap(7),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  color: hexToColor(data.progressColor),
                  backgroundColor: Colors.transparent,
                  value: data.progressValue,
                  borderRadius: BorderRadius.circular(20),

                  // trackGap: 20,
                  // stopIndicatorRadius: 50,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget browseByCategoriesView() {
  HomeController controller = Get.put(HomeController());
  List<CourseCategory> list = controller.courseCategoryList
      .take(7)
      .toList();
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    alignment: WrapAlignment.start,
    children: list.map((category) {
      return InkWell(
        onTap: () {
          Get.toNamed(
            AppRouteName.courseCategoryDetailView,
            arguments: category,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: hexToColor(category.courseBgColor),
            border: Border.all(color: hexToColor(category.courseColor), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: CommonText.semiBold(
            category.name,
            size: 14,
            color: hexToColor(category.courseColor),
          ),
        ),
      );
    }).toList(),
  );
}

Widget universityView(UniversityModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    margin: EdgeInsets.only(right: 10, bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration: isDarkMode
        ? AppCommonShadow.commonDarkBoxShadow
        : AppCommonShadow.commonBoxShadow,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonCacheImage(
          data.image,
          ImagePlaceHolder.imagePlaceHolderDark,
          fit: BoxFit.contain,
          height: 45,
          width: 45,
        ),
        Gap(7),
        CommonText.regular(data.name, size: 13),
      ],
    ),
  );
}

Widget mockTestView(QuizModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    width: 145,
    margin: EdgeInsets.only(right: 18, bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: isDarkMode
        ? AppCommonShadow.commonDarkBoxShadow
        : AppCommonShadow.commonBoxShadow,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: commonCacheImage(
            data.image,
            ImagePlaceHolder.imagePlaceHolderDark,
            fit: BoxFit.contain,
            width: double.infinity,
            height: 72,
          ),
        ),
        CommonText.medium(data.name, size: 14),
        Gap(3),
        CommonText.regular(
          "${data.noOfQuestions.toString()} ${HomeViewStrings.questions}",
          size: 12,
          color: AppColors.greyTextColor,
        ),
        Gap(12),
        PrimaryButton(
          height: 32,
          onPressed: () async {
            final homeController = Get.find<HomeController>();

            if (data.status != "Completed") {
              // 1. Mark as completed (updates UI + Firestore)
              await homeController.markQuizCompleted(data);
            }

            // 2. Always navigate to the quiz screen
            Get.toNamed(
              AppRouteName.quizView,
              arguments: {'data': data, 'type': 'test'},
            );
          },
          label: data.status == "Completed"
              ? HomeViewStrings.completed
              : HomeViewStrings.startTest,
          backgroundColor: data.status == "Completed"
              ? AppColors.success500
              : AppColors.primary500,
          textSize: 14,
        ),
      ],
    ),
  );
}

Widget bannerOne() {
  return InkWell(
    onTap: () {
      Get.toNamed(AppRouteName.quizListView);
    },
    child: Container(
      height: 90,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CommonImageAssets.takeAQuizBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    HomeViewStrings.letsTakeAQuiz,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    minFontSize: 14, // shrink until this size if needed
                    overflow: TextOverflow.visible,
                  ),
                ),
                const Gap(6),
                SvgImageFromAsset(CommonImageAssets.bulbImg),
              ],
            ),
          ),
          const SizedBox(width: 8), // space before arrow
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgImageFromAsset(
                CommonImageAssets.rightArrowImg,
                colorFilter: ColorFilter.mode(
                  AppColors.commonGradientColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bannerTwo() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      gradient: LinearGradient(
        colors: [Color(0xff134E5E), Color(0xff71B280)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.semiBold(
                HomeViewStrings.aiPoweredLearning,
                size: 20,
                color: AppColors.white,
              ),
              Gap(5),
              CommonText.regular(
                HomeViewStrings.aiPoweredLearningDes,
                size: 12,
                color: AppColors.white,
              ),
            ],
          ),
        ),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgImageFromAsset(
              CommonImageAssets.rightArrowImg,
              colorFilter: ColorFilter.mode(
                AppColors.commonGradientColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
