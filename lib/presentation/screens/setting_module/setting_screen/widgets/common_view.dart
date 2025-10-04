import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../utils/extensions/shared_preference.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';

commonView({
  required String image,
  required String title,
  void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        SvgImageFromAsset(image),
        Gap(10),
        Expanded(child: CommonText.medium(title, size: 16)),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background100,
          ),
          child: Center(
            child: SvgImageFromAsset(
              AppCommonIcon.rightArrowIcon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                AppColors.primary500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget logOutView() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgImageFromAsset(
              AppCommonIcon.closeIcon,
              colorFilter: ColorFilter.mode(
                AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Gap(10),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgImageFromAsset(
              CommonImageAssets.logOut,
              height: 48,
              width: 48,
            ),
          ),
        ),
        Gap(20),
        CommonText.medium(
          LogOutString.logOutConfirmation,
          size: 18,
          color: AppColors.primary500,
        ),
        Gap(10),
        CommonText.regular(
          LogOutString.logOutConfirmationDes,
          size: 14,
          color: isDarkMode
              ? AppColors.bodyTextDarkColor
              : AppColors.bodyTextColor,
          textAlign: TextAlign.center,
        ),
        Gap(40),
        Row(
          children: [
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  Get.back();
                },
                label: LogOutString.stayHere,
                borderSide: BorderSide(color: AppColors.primary500),
                textColor: AppColors.primary500,
                textSize: 16,
                textWeight: FontWeight.w500,
              ),
            ),
            Gap(20),
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  Get.offNamedUntil(
                    AppRouteName.signInView,
                    (route) => false,
                  );
                  AppSharedPreference.setUserLoggedIn(false);
                },
                label: LogOutString.yesLogout,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
