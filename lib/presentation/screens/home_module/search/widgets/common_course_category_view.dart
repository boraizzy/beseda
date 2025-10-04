import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../home/model/course_category.dart';

class CommonCourseCategoryView extends StatefulWidget {
  final CourseCategory course;
  const CommonCourseCategoryView({super.key, required this.course});

  @override
  State<CommonCourseCategoryView> createState() =>
      _CommonCourseCategoryViewState();
}

class _CommonCourseCategoryViewState extends State<CommonCourseCategoryView> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Row(
      children: [
        Image.asset(
          widget.course.image,
          fit: BoxFit.cover,
          height: 32,
          width: 32,
        ),
        const Gap(12),
        Expanded(
          child: CommonText.medium(
            widget.course.name,
            size: 16,
            color: isDarkMode
                ? AppColors.bodyTextDarkColor
                : AppColors.bodyTextColor,
          ),
        ),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode ? AppColors.primary500 : AppColors.background100,
          ),
          child: Center(
            child: SvgImageFromAsset(
              AppCommonIcon.rightArrowIcon,
              colorFilter: ColorFilter.mode(
                isDarkMode ? AppColors.white : AppColors.primary500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    ); // ✅ closes Row
  }
} // ✅ closes class
