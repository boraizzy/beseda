import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../controller/trainer_profile_controller.dart';

trainerProfileView() {
  TrainerProfileController controller = Get.put(TrainerProfileController());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
    child: Obx(
      () => Container(
        height: 165,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,

            image: AssetImage(CommonImageAssets.trainerProfileBg),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCacheImage(
                    controller.data.image,
                    ImagePlaceHolder.imagePlaceHolderDark,
                    fit: BoxFit.cover,
                    height: 64,
                    width: 64,
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText.semiBold(
                          controller.data.name,
                          size: 20,
                          color: AppColors.white,
                        ),
                        Gap(5),
                        CommonText.regular(
                          controller.data.qualification,
                          size: 14,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailView(
                    AppCommonIcon.groupIcon,
                    controller.detail.value.noOfStudents.toString(),
                    TrainerProfileDetailStrings.students,
                  ),
                  detailView(
                    AppCommonIcon.trainerCoursesIcon,
                    controller.detail.value.noOfCourses.toString(),
                    TrainerProfileDetailStrings.courses,
                  ),
                  detailView(
                    AppCommonIcon.reviewsIcon,
                    controller.detail.value.noOfReviews.toString(),
                    TrainerProfileDetailStrings.reviews,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

detailView(String image, String title, subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SvgImageFromAsset(image, height: 18, width: 18),
      ),
      Gap(7),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonText.semiBold(title, size: 18, color: AppColors.white),

          CommonText.regular(subtitle, size: 12, color: AppColors.white),
        ],
      ),
    ],
  );
}
