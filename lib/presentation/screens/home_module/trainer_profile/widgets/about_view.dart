import 'package:education_app/presentation/common_widgets/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../controller/trainer_profile_controller.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  TrainerProfileController controller = Get.put(TrainerProfileController());

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Obx(() {
      var data = controller.detail.value;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(20),
              CommonText.regular(
                TrainerProfileDetailStrings.description,
                size: 14,
                color: isDarkMode
                    ? AppColors.bodyTextDarkColor
                    : AppColors.bodyTextColor,
              ),
              Gap(15),
              ListView.builder(
                itemCount: data.descriptionList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: CircleAvatar(
                            radius: 2,
                            backgroundColor: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                          ),
                        ),
                        Gap(7),
                        Expanded(
                          child: CommonText.regular(
                            data.descriptionList[index],
                            size: 14,
                            color: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Gap(15),
              CommonText.regular(
                data.description,
                size: 14,
                color: isDarkMode
                    ? AppColors.bodyTextDarkColor
                    : AppColors.bodyTextColor,
              ),
              Gap(15),
              CommonText.semiBold(
                TrainerProfileDetailStrings.connectMe,
                size: 16,
              ),
              Gap(25),
              socialMediaView(
                CommonImageAssets.facebook,
                TrainerProfileDetailStrings.facebook,
              ),
              Gap(20),
              socialMediaView(
                CommonImageAssets.instagram,
                TrainerProfileDetailStrings.instagram,
              ),
              Gap(20),
              socialMediaView(
                CommonImageAssets.youtube,
                TrainerProfileDetailStrings.youTube,
              ),
            ],
          ),
        ),
      );
    });
  }

  socialMediaView(String image, name) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Row(
      children: [
        SvgImageFromAsset(image),
        Gap(12),
        Expanded(
          child: CommonText.medium(
            name,
            size: 14,
            color: isDarkMode
                ? AppColors.bodyTextDarkColor
                : AppColors.bodyTextColor,
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: isDarkMode?AppColors.cardDarkBg2Color:AppColors.cardBgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: isDarkMode?AppColors.grey100Color:AppColors.primary500,width: 1),
            
          ),
          child: Center(
            child: SvgImageFromAsset(
              CommonImageAssets.send,
              colorFilter: ColorFilter.mode(
                isDarkMode ? AppColors.bodyTextDarkColor : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
