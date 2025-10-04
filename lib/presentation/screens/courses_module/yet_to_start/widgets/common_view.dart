import 'package:education_app/presentation/common_widgets/widgets/button.dart';
import 'package:education_app/presentation/common_widgets/widgets/common_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/app_route.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';

Widget liveSessionView() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SvgImageFromAsset(CommonImageAssets.generic),
      Gap(12),
      Container(
        height: 24,
        width: 49,
        decoration: BoxDecoration(
          color: AppColors.error500,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: CommonText.semiBold(
            MeetingJoiningStrings.live,
            size: 11,
            color: AppColors.white,
          ),
        ),
      ),
      Gap(12),
      Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.error500, width: 2),
        ),
        child: Center(
          child: CircleAvatar(radius: 5, backgroundColor: AppColors.error500),
        ),
      ),
      Gap(12),
      Container(
        height: 24,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.greyBgColor,
          border: Border.all(color: AppColors.greyColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SvgImageFromAsset(AppCommonIcon.showPasswordIcon),
            Gap(5),
            CommonText.semiBold(
              '1.2K',
              size: 12,
              color: AppColors.bodyTextColor,
            ),
          ],
        ),
      ),
      Spacer(),
      SvgImageFromAsset(AppCommonIcon.meetingCamera),
      Gap(12),
      SvgImageFromAsset(AppCommonIcon.volumeIcon),
    ],
  );
}

Widget commonBottomViewOfMeeting(void Function()? onTap, BuildContext context) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    decoration: isDarkMode
        ? AppCommonShadow.commonMeetingDarkBoxShadow
        : AppCommonShadow.commonMeetingBoxShadow,
    child: SafeArea(
      top: false,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                commonDialog(
                  context: context,
                  view: leaveSessionDialog(),
                  insetPadding: EdgeInsets.symmetric(horizontal: 20),
                );
              },
              child: SvgImageFromAsset(CommonImageAssets.meetingLogOut),
            ),
            Gap(20),
            InkWell(
              onTap: onTap,
              child: SvgImageFromAsset(CommonImageAssets.handsUp),
            ),
            Gap(20),
            InkWell(
              onTap: () {
                Get.toNamed(
                  AppRouteName.aiChatbotView,
                  arguments: 'Live Session',
                );
              },
              child: SvgImageFromAsset(CommonImageAssets.meetingChat),
            ),
            Gap(20),
            InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.participantsListView);
              },
              child: SvgImageFromAsset(CommonImageAssets.participants),
            ),
          ],
        ),
      ),
    ),
  );
}

leaveSessionDialog() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgImageFromAsset(AppCommonIcon.warningIcon),
            Gap(5),
            Expanded(
              child: CommonText.semiBold(
                ParticipantsString.leaveSession,
                size: 20,
                color: AppColors.error500,
              ),
            ),
            InkWell(
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
          ],
        ),
        Gap(15),
        CommonText.regular(
          ParticipantsString.leaveSessionDes,
          size: 16,
          color: isDarkMode
              ? AppColors.bodyTextDarkColor
              : AppColors.bodyTextColor,
        ),
        Gap(20),
        ErrorButton(
          onPressed: () {
            Get.back();
            Get.toNamed(AppRouteName.leaveSessionConfirmationView);
          },
          label: ParticipantsString.leaveSession,
        ),
      ],
    ),
  );
}
