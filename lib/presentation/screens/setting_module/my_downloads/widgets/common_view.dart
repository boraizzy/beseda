import 'package:education_app/presentation/common_widgets/widgets/common_divider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/input_field/common_text_field.dart';
import '../../../../common_widgets/widgets/button.dart';
import '../../../../common_widgets/widgets/common_alert_dialog.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../../home_module/home/model/course_model.dart';
import '../controller/my_downloads_controller.dart';
import '../model/documents_model.dart';

Widget videoLectureView(CourseModel data, BuildContext context, int index) {
  MyDownloadsController controller = Get.put(MyDownloadsController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;

  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            commonCacheImage(
              data.image,
              ImagePlaceHolder.imagePlaceHolderDark,
              fit: BoxFit.fill,
              height: 75,
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Icon(Icons.play_arrow, color: AppColors.white, size: 20),
            ),

            Positioned(
              right: 10,
              bottom: 10,
              child: CommonText.semiBold(
                '10:23',
                size: 12,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(
                data.name,
                size: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(2),
              CommonText.medium(
                data.date,
                size: 12,
                color: isDarkMode
                    ? AppColors.bodyTextDarkColor
                    : AppColors.bodyTextColor,
              ),
              Gap(2),
              CommonText.medium(
                '${data.storage.toString()} MB',
                size: 12,
                color: isDarkMode
                    ? AppColors.greyTextDarkColor
                    : AppColors.greyTextColor,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.nameController.text = data.name;
            commonDialog(
              context: context,
              view: dialogView(
                context: context,
                title: MyDownloadsString.deleteVideo,
                subtitle: MyDownloadsString.deleteVideoDes,
                deleteOnPressed: () {
                  controller.deleteVideo(index, context);
                  // controller.videoLectureList.removeAt(index);
                  // Get.back();
                  // showSuccessMessage(
                  //   context: context,
                  //   title: MyDownloadsString.videoDeleteSuccessfully,
                  //   content: '',
                  // );
                },
                nameController: controller.nameController,
                renameOnPressed: () {
                  controller.updateVideoName(data, context);
                },
              ),
            );
          },

          child: SvgImageFromAsset(
            AppCommonIcon.dotsVerticalIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? AppColors.white : AppColors.headingsColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget documentView(DocumentsModel data, BuildContext context, int index) {
  MyDownloadsController controller = Get.put(MyDownloadsController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgImageFromAsset(CommonImageAssets.coursePdf),
        Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(
                data.name,
                size: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(2),
              Row(
                children: [
                  CommonText.medium(
                    data.date,
                    size: 12,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                  Gap(7),
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: isDarkMode
                        ? AppColors.greyTextDarkColor
                        : AppColors.greyTextColor,
                  ),
                  Gap(7),
                  CommonText.medium(
                    '${data.storage.toString()} MB',
                    size: 12,
                    color: isDarkMode
                        ? AppColors.greyTextDarkColor
                        : AppColors.greyTextColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.nameController.text = data.name;
            commonDialog(
              context: context,
              view: dialogView(
                context: context,
                title: MyDownloadsString.deleteDocument,
                subtitle: MyDownloadsString.deleteDocumentDes,
                deleteOnPressed: () {
                  controller.deleteDocument(index, context);
                },
                nameController: controller.nameController,
                renameOnPressed: () {
                  controller.updateDocumentName(data, context);
                },
              ),
            );
          },

          child: SvgImageFromAsset(
            AppCommonIcon.dotsVerticalIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? AppColors.white : AppColors.headingsColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget audioView(DocumentsModel data, BuildContext context, int index) {
  MyDownloadsController controller = Get.put(MyDownloadsController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgImageFromAsset(CommonImageAssets.audio),
        Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(
                data.name,
                size: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(2),
              Row(
                children: [
                  CommonText.medium(
                    data.date,
                    size: 12,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                  Gap(7),
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: isDarkMode
                        ? AppColors.greyTextDarkColor
                        : AppColors.greyTextColor,
                  ),
                  Gap(7),
                  CommonText.medium(
                    '${data.storage.toString()} KB',
                    size: 12,
                    color: isDarkMode
                        ? AppColors.greyTextDarkColor
                        : AppColors.greyTextColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.nameController.text = data.name;
            commonDialog(
              context: context,
              view: dialogView(
                context: context,
                title: MyDownloadsString.deleteAudio,
                subtitle: MyDownloadsString.deleteAudioDes,
                deleteOnPressed: () {
                  controller.deleteAudio(index, context);
                },
                nameController: controller.nameController,
                renameOnPressed: () {
                  controller.updateAudioName(data, context);
                },
              ),
            );
          },

          child: SvgImageFromAsset(
            AppCommonIcon.dotsVerticalIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? AppColors.white : AppColors.headingsColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dialogView({
  required BuildContext context,
  required String title,
  required String subtitle,
  required void Function()? deleteOnPressed,
  required TextEditingController nameController,
  required void Function()? renameOnPressed,
}) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                isDarkMode ? AppColors.bodyTextDarkColor : AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Gap(10),
        InkWell(
          onTap: () {
            commonDialog(
              context: context,
              view: renameView(
                nameController: nameController,
                renameOnPressed: renameOnPressed,
              ),
            ).then((value) => Get.back());
          },
          child: Row(
            children: [

              SvgImageFromAsset(
                AppCommonIcon.editIcon,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? AppColors.white : AppColors.headingsColor,
                  BlendMode.srcIn,
                ),
              ),
              Gap(10),
              CommonText.medium(MyDownloadsString.rename, size: 16),
            ],
          ),
        ),
        Gap(15),
        CommonDivider(
          color: isDarkMode
              ? AppColors.grey100Color
              : AppColors.borderSecondaryColor,
        ),
        Gap(15),

        InkWell(
          onTap: () {
            commonDialog(
              context: context,
              view: deleteView(
                title: title,
                subtitle: subtitle,
                deleteOnPressed: deleteOnPressed,
              ),
            ).then((value) => Get.back());
          },
          child: Row(
            children: [
              SvgImageFromAsset(
                AppCommonIcon.deleteIcon,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? AppColors.white : AppColors.headingsColor,
                  BlendMode.srcIn,
                ),
              ),
              Gap(10),
              CommonText.medium(MyDownloadsString.delete, size: 16),
            ],
          ),
        ),
        Gap(15),
        CommonDivider(
          color: isDarkMode
              ? AppColors.grey100Color
              : AppColors.borderSecondaryColor,
        ),
        Gap(15),

        InkWell(
          onTap: () {
            SharePlus.instance.share(
              ShareParams(text:   title,),
            );
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.send,color: isDarkMode ? AppColors.white : AppColors.headingsColor,size: 20,),
              Gap(10),
              // SvgImageFromAsset(
              //   AppCommonIcon.se,
              //   height: 20,
              //   width: 20,
              //   colorFilter: ColorFilter.mode(
              //     isDarkMode ? AppColors.white : AppColors.headingsColor,
              //     BlendMode.srcIn,
              //   ),
              // ),
              CommonText.medium(MyDownloadsString.share, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget deleteView({
  required String title,
  required String subtitle,
  required void Function()? deleteOnPressed,
}) {
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
                title,
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
                  isDarkMode?AppColors.bodyTextDarkColor:AppColors.greyColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        Gap(15),
        CommonText.regular(
          subtitle,
          size: 16,
          color: isDarkMode
              ? AppColors.bodyTextDarkColor
              : AppColors.bodyTextColor,
        ),
        Gap(20),
        Row(
          children: [
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  Get.back();
                },
                label: AppCommonStrings.btnCancel,
                borderSide: BorderSide(color: AppColors.error500),
                textColor: AppColors.error500,
                textSize: 18,
                textWeight: FontWeight.w600,
              ),
            ),
            Gap(20),
            Expanded(
              child: ErrorButton(
                onPressed: deleteOnPressed,
                label: MyDownloadsString.delete,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget renameView({
  required TextEditingController nameController,
  required void Function()? renameOnPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.semiBold(
              MyDownloadsString.rename,
              size: 20,
              color: AppColors.primary500,
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
        CommonTextField(
          textInputAction: TextInputAction.done,
          fillColor: Colors.transparent,
          controller: nameController,
        ),
        Gap(25),
        Row(
          children: [
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  Get.back();
                },
                label: AppCommonStrings.btnCancel,
                borderSide: BorderSide(color: AppColors.primary500),
                textColor: AppColors.primary500,
                textSize: 18,
                textWeight: FontWeight.w600,
              ),
            ),
            Gap(20),
            Expanded(
              child: PrimaryButton(
                onPressed: renameOnPressed,
                label: MyDownloadsString.rename,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

