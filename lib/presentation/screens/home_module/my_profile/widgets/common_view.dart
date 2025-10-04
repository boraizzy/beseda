import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../home/model/course_model.dart';
import '../controller/my_profile_controller.dart';
import '../../../courses_module/my_courses/controller/my_courses_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  SliverTabBarDelegate(this.tabBar, {required this.backgroundColor});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}

TabBar commonTabBar({
  required TabController tabController,
  required String firstTabTitle,
  required String secondTabTitle,
}) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return TabBar(
    controller: tabController,
    labelColor: AppColors.lightPrimaryColor,
    dividerColor: isDarkMode ? AppColors.grey100Color : AppColors.greyColor,
    unselectedLabelStyle: TextStyle(
      color: isDarkMode ? AppColors.bodyTextDarkColor : AppColors.bodyTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    labelStyle: TextStyle(
      color: AppColors.lightPrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    indicator: BoxDecoration(
      color: isDarkMode ? AppColors.cardDarkBg2Color : AppColors.primary50,
      border: Border(bottom: BorderSide(color: AppColors.primary500)),
    ),

    indicatorSize: TabBarIndicatorSize.tab,
    tabs: [
      Tab(text: firstTabTitle),
      Tab(text: secondTabTitle),
    ],
  );
}
Widget myProfileAppBar(){
  const double horizontalSpacing = 20;
  return  Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff375EDF), Color(0xff269BE0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalSpacing,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: SvgImageFromAsset(
                AppCommonIcon.backIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Gap(15),
            CommonText.semiBold(
              MyProfileViewStrings.myProfile,
              size: 18,
              color: AppColors.white,
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  Get.find<MyProfileController>().updateProfileImage(File(picked.path));
                }
              },
              child: SvgImageFromAsset(AppCommonIcon.editIcon),
            ),
          ],
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
}
Widget headerView() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  MyProfileController controller = Get.put(MyProfileController());

  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: SizedBox(
      height: 360,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 290,
            decoration: BoxDecoration(
              //color: Colors.yellow
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff375EDF), Color(0xff269BE0)],
              ),
            ),
            child: Obx(
              () => Column(
                children: [
                  Gap(12),

                  Obx(() {
                    final profileUrl = controller.userData.value.profileUrl;

                    if (profileUrl.isNotEmpty && profileUrl.startsWith('/')) {
                      // ✅ Local file
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: Image.file(
                          File(profileUrl),
                          height: 72,
                          width: 72,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      // ✅ Network or placeholder
                      return commonCacheImage(
                        profileUrl,
                        UserPlaceholderAssets.userPlaceHolderLight,
                        fit: BoxFit.cover,
                        height: 72,
                        width: 72,
                      );
                    }
                  }),
                  Gap(15),
                  CommonText.semiBold(
                    controller.userData.value.name,
                    size: 20,
                    textAlign: TextAlign.center,
                    color: AppColors.white,
                  ),
                  Gap(7),
                  CommonText.light(
                    controller.userData.value.email,
                    size: 14,
                    textAlign: TextAlign.center,
                    color: AppColors.white,
                  ),
                  Gap(15)
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 25,
            right: 25,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: isDarkMode
                  ? AppCommonShadow.commonDarkBoxShadow
                  : AppCommonShadow.commonBoxShadow,
              child: Column(
                children: [
                  courseDetail(
                    AppColors.cardBgColor,
                    isDarkMode ? AppColors.primary300 : AppColors.primary500,
                    AppColors.primary300,
                    Get.find<MyCoursesController>().myCoursesList.length.toString(),
                    "Записани курсове",
                    CommonImageAssets.courseEnrolled,
                  ),
                  Gap(20),
                  courseDetail(
                    AppColors.secondary50,
                    isDarkMode ? AppColors.secondary300 : AppColors.secondary500,
                    AppColors.secondary300,
                    "Идва скоро",
                    "Среден Резултат",
                    CommonImageAssets.averageScore,
                  ),
                  Gap(20),
                  courseDetail(
                    AppColors.success50,
                    isDarkMode ? AppColors.success300 : AppColors.success500,
                    AppColors.success300,
                    "Идва скоро",
                    "Дни в обучение",
                    CommonImageAssets.calender,
                  ),
                  Gap(20),
                  courseDetail(
                    AppColors.error50,
                    isDarkMode ? AppColors.error300 : AppColors.error500,
                    AppColors.error300,
                    "Идва скоро",
                    "Общо Монети",
                    CommonImageAssets.coins,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget coursesView(CourseModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: isDarkMode
        ? AppCommonShadow.commonDarkBoxShadow
        : AppCommonShadow.commonBoxShadow,
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonCacheImage(
              data.image,
              ImagePlaceHolder.imagePlaceHolderLight,
              fit: BoxFit.cover,
              height: 25,
              width: 25,
            ),
            CommonText.medium(
              data.date,
              size: 12,
              color: isDarkMode
                  ? AppColors.greyTextDarkColor
                  : AppColors.greyTextColor,
            ),
          ],
        ),
        Gap(10),
        CommonText.semiBold(data.name, size: 14),
        Gap(10),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                color: AppColors.primary500,
                value: 100,
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Gap(20),
            CommonText.medium(
              '${data.noOfCompletedLectures}/${data.noOfLectures}',
              size: 14,
              color: AppColors.success500,
            ),
          ],
        ),
      ],
    ),
  );
}

courseDetail(Color? color, textColor, imgColor, String title, subtitle, image) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? AppColors.greyDarkColor : color,
        ),
        child: Center(
          child: SvgImageFromAsset(
            image,
            colorFilter: isDarkMode
                ? ColorFilter.mode(imgColor, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
      Gap(5),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.semiBold(
            title,
            size: 16,
            textAlign: TextAlign.center,
            color: textColor,
          ),
          Gap(2),
          CommonText.medium(
            subtitle,
            size: 12,
            textAlign: TextAlign.center,
            color: AppColors.greyTextColor,
          ),
        ],
      ),
    ],
  );
}
