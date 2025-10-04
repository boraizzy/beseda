import 'package:education_app/presentation/app/app_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../quiz_list/model/quiz_model.dart';
import '../controller/quiz_controller.dart';

bool isDarkMode = Get.find<ThemeController>().isDarkMode;
Widget buildCheck() => CircleAvatar(
  backgroundColor: AppColors.success100,
  radius: 15,
  child: SvgImageFromAsset(AppCommonIcon.checkIcon),
);
Widget buildUnCheck() => CircleAvatar(
  backgroundColor: isDarkMode ? AppColors.grey100Color : AppColors.greyColor,
  radius: 15,
  child: Center(child: Icon(Icons.check,size: 15,color: AppColors.white,)),
);

Widget buildWrong() => CircleAvatar(
  backgroundColor: AppColors.error100,
  radius: 15,
  child: SvgImageFromAsset(AppCommonIcon.closeIconWithColor),
);

Widget buildKeyCircle(String key) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.secondary40,
    ),
    child: Center(
      child: CommonText.semiBold(key, size: 20, color: AppColors.secondary500),
    ),
  );
}

Widget buildRadioCircle(bool isSelected) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    height: 24,
    width: 24,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isSelected ? AppColors.primary500 : Colors.transparent,
      border: Border.all(
        color: isSelected
            ? Colors.transparent
            : isDarkMode
            ? AppColors.grey100Color
            : AppColors.greyColor,
        width: 1,
      ),
    ),
    child: Center(
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? isDarkMode
                    ? AppColors.cardDarkBg2Color
                    : AppColors.white
              : Colors.transparent,
        ),
      ),
    ),
  );
}

Color? getColorForSubmitted(QuizModel data, int index) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  if (index == data.correctOptionIndex) {
    return isDarkMode ? AppColors.success100 : AppColors.success50;
  }
  if (index == data.selectedOptionIndex &&
      data.selectedOptionIndex != data.correctOptionIndex) {
    return isDarkMode ? AppColors.error100 : AppColors.error50;
  }
  return Colors.transparent;
}

getBorderColorForSubmitted(QuizModel data, int index) {
  if (index == data.correctOptionIndex) return AppColors.success500;
  if (index == data.selectedOptionIndex &&
      data.selectedOptionIndex != data.correctOptionIndex) {
    return AppColors.error500;
  }
  return Colors.transparent;
}

getTextColorForSubmitted(QuizModel data, int index) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  if (index == data.correctOptionIndex) {
    return isDarkMode ? AppColors.headingsColor : AppColors.bodyTextColor;
  }
  if (index == data.selectedOptionIndex &&
      data.selectedOptionIndex != data.correctOptionIndex) {
    return isDarkMode ? AppColors.headingsColor : AppColors.bodyTextColor;
  }
  return isDarkMode ? AppColors.bodyTextDarkColor : AppColors.bodyTextColor;
}

Future<void> showConfirmationDialog(BuildContext context) async {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  QuizController controller = Get.put(QuizController());
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Get.find<ThemeController>().isDarkMode
            ? AppColors.headingsColor
            : AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgImageFromAsset(AppCommonIcon.closeIcon),
                  ),
                ),
                Gap(12),
                Image.asset(CommonImageAssets.penTick, width: 72, height: 65),
                Gap(20),
                CommonText.semiBold(
                  controller.data!.name,
                  size: 19,
                  color: AppColors.primary500,
                  textAlign: TextAlign.center,
                ),
                Gap(15),
                CommonText.regular(
                  controller.type != null
                      ? TestPopUpStrings.testDes
                      : QuizPopUpStrings.leaveQuizDescription,
                  size: 14,
                  color: isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                  textAlign: TextAlign.center,
                ),
                Gap(50),
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: controller.type != null
                      ? TestPopUpStrings.continueTest
                      : QuizPopUpStrings.continueQuiz,
                  borderSide: BorderSide(color: AppColors.primary500),
                  textColor: AppColors.primary500,
                  textSize: 16,
                  textWeight: FontWeight.w500,
                ),
                Gap(15),
                PrimaryButton(
                  onPressed: () {
                    Get.offNamedUntil(
                      AppRouteName.bottomView,
                      (route) => route.isFirst,
                    );
                  },
                  label: controller.type != null
                      ? TestPopUpStrings.leaveTest
                      : QuizPopUpStrings.leaveQuiz,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
