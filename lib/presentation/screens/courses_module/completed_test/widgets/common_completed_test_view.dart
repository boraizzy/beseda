import 'package:education_app/core/constants/app_colors.dart';
import 'package:education_app/presentation/common_widgets/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';

Widget commonCompletedTestView(String image, title, subtitle) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgImageFromAsset(image),
      Gap(25),
      CommonText.semiBold(title, size: 22, color: AppColors.primary500),
      Gap(12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CommonText.regular(
          subtitle,
          size: 16,
          color: isDarkMode
              ? AppColors.bodyTextDarkColor
              : AppColors.bodyTextColor,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget excellentView() {
  return commonCompletedTestView(
    CommonImageAssets.excellent,
    CompletedTestStrings.wellDoneChampion,
    CompletedTestStrings.wellDoneChampionDes,
  );
}

Widget goodJobView() {
  return commonCompletedTestView(
    CommonImageAssets.goodJob,
    CompletedTestStrings.aSolidAttempts,
    CompletedTestStrings.aSolidAttemptsDes,
  );
}

Widget keepTryingView() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return commonCompletedTestView(
    isDarkMode
        ? CommonImageAssets.darkKeepTrying
        : CommonImageAssets.keepTrying,
    CompletedTestStrings.keepTrying,
    CompletedTestStrings.keepTryingDes,
  );
}
