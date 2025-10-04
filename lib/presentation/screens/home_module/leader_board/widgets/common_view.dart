import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/text.dart';

commonLevel(String name) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;

  return CommonText.medium(
    name,
    size: 15,
    color: isDarkMode?AppColors.white:AppColors.primary500,
    textAlign: TextAlign.center,
  );
}

commonText(String name,Color? color) {
  return CommonText.regular(name, size: 15, textAlign: TextAlign.center,color:color ,);
}


