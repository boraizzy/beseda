import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_divider.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../controller/course_detail_controller.dart';
import 'common_view.dart';
class RatingReview extends StatefulWidget {
  const RatingReview({super.key});

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  CourseDetailController controller = Get.put(CourseDetailController());

  @override
  Widget build(BuildContext context) {
     const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalSpacing,
            ),
            child: Row(
              children: [
                SvgImageFromAsset(AppCommonIcon.starIcon),
                Gap(5),
                CommonText.semiBold(
                  controller.detail.value.courseRating.toString(),
                  size: 20,

                ),
                Gap(5),

                Expanded(
                  child: CommonText.regular(
                    CourseDetailStrings.courseRating,
                    size: 14,
                    color: isDarkMode
                        ? AppColors.bodyTextDarkColor
                        :AppColors.bodyTextColor,

                  ),
                ),
                CommonText.medium(
                  '${controller.detail.value.reviewList.length.toString()} Reviews',
                  size: 14,

                ),
              ],
            ),
          ),
          Gap(12),
          CommonDivider(),
          Gap(12),
          Obx(() {
            final reviews = controller.detail.value.reviewList;
            final showAll = controller.showAllReviews.value;

            final visibleReviews = showAll
                ? reviews
                : reviews.take(6).toList(); // Only show 6 if not expanded

            return Column(
              children: [
                ListView.builder(
                  itemCount: visibleReviews.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  itemBuilder: (context, index) {
                    final data = visibleReviews[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CommonText.medium(
                                data.name,
                                size: 14,
                              ),
                              Spacer(),
                              RatingBar.readOnly(
                                size: 16,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                         
                                initialRating: data.rate,
                                alignment: Alignment.center,


                              ),
                            ],
                          ),
                          Gap(7),
                          CommonText.regular(
                            data.time,
                            size: 12,
                            color: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                :AppColors.bodyTextColor,
                          ),
                          Gap(12),
                          CommonText.regular(
                            data.msg,
                            size: 14,
                            color: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                :AppColors.bodyTextColor,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // View More / View Less Button
                if (reviews.length > 6)
                  Gap(20),
                if (reviews.length > 6)
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        controller.showAllReviews.toggle();
                      },
                      child: CommonText.semiBold(
                        controller.showAllReviews.value
                            ? "View Less Reviews"
                            : "View More Reviews",
                        size: 14,
                        color: AppColors.primary500,
                      ),
                    ),
                  ),
              ],
            );
          }),

          Gap(20),
          courseBottomView()

        ],
      ),
    );
  }
}
