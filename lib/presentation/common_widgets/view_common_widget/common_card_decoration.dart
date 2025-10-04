import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../app/theme_controller.dart';

BoxDecoration commonCardDecoration(){
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return  BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage(isDarkMode?CommonImageAssets.darkInterestSubjectBg:CommonImageAssets.interestSubjectBg),
    ),
  );
}
BoxDecoration commonGradiantDecoration(){
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return  BoxDecoration(
    color: isDarkMode?AppColors.mainDarkBgColor:null,
    gradient: isDarkMode?null:AppCommonGradient.backgroundGradient,
  );
}