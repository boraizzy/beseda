import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/text.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OnboardingPage(this.image, this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    const double _ = 20;
    const double horizontalSpacing = 30;

    // OnboardingPage
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Center(child: Image.asset(image, width: 210, height: 320)),
          Gap(25),
          // Title
          CommonText.bold(
            title,
            size: 24,
            height: 1.0,
            letterSpacing: 0.0,
            textAlign: TextAlign.center,
          ),
          Gap(25),
          // Subtitle
          CommonText.regular(
            subtitle,
            size: 16,
            color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
