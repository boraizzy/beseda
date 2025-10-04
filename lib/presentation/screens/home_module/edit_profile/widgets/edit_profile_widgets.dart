import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_alert_dialog.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../controller/edit_profile_controller.dart';

EditProfileController controller = Get.put(EditProfileController());



pickDocumentDialog({
  void Function()? cameraOnTap,
  void Function()? galleryTap,
  void Function()? fileOnTap,
  bool document=false

}
    ){
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.medium(
              EditProfileViewStrings.selectImage,
              size: 18,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgImageFromAsset(AppCommonIcon.closeIcon),
            ),
          ],
        ),
        Gap(20),
        Divider(
          color: isDarkMode
              ? AppColors.borderDarkSecondaryColor
              : AppColors.borderSecondaryColor,
        ),
        Gap(20),
        InkWell(
          onTap: cameraOnTap,
          child: commonView(
            AppCommonIcon.cameraIcon,
              EditProfileViewStrings.pickImageFromCamera

          ),
        ),
        Gap(15),
        Divider(
          color: isDarkMode
              ? AppColors.borderDarkSecondaryColor
              : AppColors.borderSecondaryColor,
        ),
        Gap(15),
        InkWell(
          onTap: galleryTap,
          child: commonView(
            AppCommonIcon.galleryIcon,
              EditProfileViewStrings.pickImageFromGallery

          ),
        ),
        Gap(15),
        document? Divider(
          color: isDarkMode
              ? AppColors.borderDarkSecondaryColor
              : AppColors.borderSecondaryColor,
        ):SizedBox(),
        Gap(document?15:0),
        document?InkWell(
          onTap: fileOnTap,
          child: commonView(
              AppCommonIcon.fileIcon,
              'Pick Document'

          ),
        ):SizedBox()
      ],
    ),
  );
}


Widget commonView(String image,title) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.greyDarkColor : AppColors.greyBgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgImageFromAsset(
            image,
            colorFilter: ColorFilter.mode(
              isDarkMode ? AppColors.white : AppColors.headingsColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      Gap(10),


      CommonText.medium(
        title,
        size: 14,
      ),
    ],
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
        title: EditProfileViewStrings.areYouSure,
        subTitle: EditProfileViewStrings.wantToDeleteProfileImg,
        primaryButtonTitle: NotificationViewStrings.delete,
        primaryButtonPressed: onConfirm,
      );
    },
  );
}
