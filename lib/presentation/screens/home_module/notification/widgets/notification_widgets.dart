import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_alert_dialog.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../model/notification_model.dart';

Widget notificationView(NotificationListModel data) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    decoration: BoxDecoration(
      color: data.marAsRead
          ? Colors.transparent
          : isDarkMode
          ?
      //AppColors.cardDarkBgColor
      AppColors.brand950
          : AppColors.cardBgColor,
      // border: Border(
      //   bottom: BorderSide(color: AppColors.greyColor, width: 1),
      // ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.medium(data.title, size: 16),
          Gap(10),
          CommonText.regular(data.msg, size: 14, color: AppColors.greyTextColor),
        ],
      ),
    ),
  );
}



Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    VoidCallback onConfirm,
    ) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CommonAlertDialog(
        title: NotificationViewStrings.deleteMessage,
        subTitle: NotificationViewStrings.deleteMessageDes,
        primaryButtonTitle: NotificationViewStrings.delete,
        primaryButtonPressed: onConfirm,
      );
    },
  );
}