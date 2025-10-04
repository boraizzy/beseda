import 'package:education_app/presentation/common_widgets/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../core/themes/app_size.dart';
import '../../app/theme_controller.dart';
import 'image.dart';

class SocialButtonWithTitle extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;
final ColorFilter? colorFilter;
  const SocialButtonWithTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed, this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color:
                Get.find<ThemeController>().isDarkMode
                    ? AppColors.grey100Color
                    : AppColors.greyColor,
          ), // Customize border color as needed
          borderRadius: ShapeBorderRadius.small, // Customize border radius as needed
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImageFromAsset(icon,colorFilter: colorFilter,),
            const Gap(10),
            CommonText.medium(
              title,
              size: 16,

            ),
          ],
        ),
      ),
    );
  }
}
