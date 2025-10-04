import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/view_common_widget/common_course_view.dart';
import '../../../../common_widgets/widgets/common_alert_dialog.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../home/model/course_model.dart';

Widget cartView({
  required CourseModel data,
  required BuildContext context,
  void Function()? onTap,
  void Function()? wishlistOnTap,
  required bool showRemoveOrWishlist
}) {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  //CourseCartController controller = Get.put(CourseCartController());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: commonCacheImage(
            data.image,
            ImagePlaceHolder.imagePlaceHolderDark,
            //fit: BoxFit.fill,
            width: 72,
            height: 54,
          ),
        ),
        Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(data.name, size: 14),
              Gap(7),
              Row(
                children: [
                  commonPriceText(data.courseFees.toString()),
                  Gap(12),
                  SvgImageFromAsset(
                    AppCommonIcon.starIcon,
                    height: 12,
                    width: 12,
                  ),
                  Gap(3),
                  CommonText.medium(
                    data.rate.toString(),
                    size: 16,
                    color: AppColors.secondary500,
                  ),
                ],
              ),
              Gap(7),
              Wrap(
                spacing: 5,
                runSpacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CommonText.regular(
                    '${data.sessions} Сесии',
                    size: 12,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: isDarkMode
                        ? AppColors.greyTextDarkColor
                        : AppColors.greyTextColor,
                  ),
                  CommonText.regular(
                    '${data.noOfLectures} Лекции',
                    size: 12,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        : AppColors.bodyTextColor,
                  ),
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: AppColors.greyTextColor,
                  ),
                  CommonText.regular(
                    data.level,
                    size: 12,
                    color: AppColors.bodyTextColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Gap( showRemoveOrWishlist?7:0),

              showRemoveOrWishlist? Wrap(
                spacing: 10,
                runSpacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgImageFromAsset(
                          AppCommonIcon.deleteIcon,
                          height: 15,
                          width: 15,
                          colorFilter: ColorFilter.mode(AppColors.error500, BlendMode.srcIn),
                        ),
                        Gap(3),
                        CommonText.semiBold(
                          AppCommonStrings.btnRemove,
                          size: 14,
                          color: AppColors.error500,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: wishlistOnTap,

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgImageFromAsset(
                          AppCommonIcon.likeIcon,
                          height: 15,
                          width: 15,
                          colorFilter: ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
                        ),
                        Gap(3),
                        CommonText.semiBold(
                          CourseCartStrings.moveToWishList,
                          size: 14,
                          color: AppColors.primary500,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )

                ],
              ):SizedBox(),

            ],
          ),
        ),
      ],
    ),
  );
}

Future<void> showRemoveConfirmationDialog(
  BuildContext context,
  VoidCallback onConfirm,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CommonAlertDialog(
        title: CourseCartStrings.removeFromCart,
        subTitle: CourseCartStrings.removeFromCartDes,
        primaryButtonTitle: AppCommonStrings.btnRemove,
        primaryButtonPressed: onConfirm,
      );
    },
  );
}
