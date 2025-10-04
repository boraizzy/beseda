import 'package:education_app/presentation/common_widgets/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../app/theme_controller.dart';
import '../widgets/text.dart';

Widget commonSeeAllText(String leading,bool seeAll, void Function()? onPressed) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: CommonText.semiBold(
          leading,
          size: 16,
          height: 1.0,
          letterSpacing: 0.0,
          textAlign: TextAlign.start,
          maxLines: 2,
          //color: isDarkMode?AppColors.white:AppColors.headingsColor,
        ),
      ),
      seeAll?
      InkWell(
        onTap:seeAll? onPressed:null,
        child: Row(
          children: [
            CommonText.regular(
              HomeViewStrings.seeAll,
              size: 14,
              height: 1.0,
              letterSpacing: 0.0,
              textAlign: TextAlign.center,
              color:isDarkMode?AppColors.greyTextDarkColor: AppColors.greyTextColor,
            ),
            Gap(3),
            SvgImageFromAsset(AppCommonIcon.rightArrowIcon),
          ],
        ),
      ):SizedBox.shrink(),
    ],
  );
}
