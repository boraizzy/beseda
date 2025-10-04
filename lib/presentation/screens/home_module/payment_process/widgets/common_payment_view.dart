import 'package:education_app/core/constants/app_colors.dart';
import 'package:education_app/presentation/common_widgets/widgets/image.dart';
import 'package:education_app/presentation/common_widgets/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../app/theme_controller.dart';

Widget commonPaymentView(String image, title, subtitle, Color textColor) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgImageFromAsset(image),
      Gap(20),
      CommonText.semiBold(title, size: 22, color: textColor),
      Gap(15),
      CommonText.regular(
        subtitle,
        size: 14,
        color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
