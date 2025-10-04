  part of 'university_detail_imports.dart';

  class UniversityDetailView extends StatefulWidget {
    const UniversityDetailView({super.key});

    @override
    State<UniversityDetailView> createState() => _UniversityDetailViewState();
  }

  class _UniversityDetailViewState extends State<UniversityDetailView> {
    UniversityModelDetailController controller = Get.put(
      UniversityModelDetailController(),
    );
    @override
    Widget build(BuildContext context) {
      const double horizontalSpacing = 20;
      bool isDarkMode = Get.find<ThemeController>().isDarkMode;
      return Scaffold(
        body: Container(
          height: context.height,
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? AppCommonGradient.mainDarkBackgroundGradient
                : AppCommonGradient.mainBackgroundGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CommonAppbar(title: controller.data.name),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                controller.data.noOfCourses == 0
                                    ? controller.detail.value.image
                                    : controller.data.image,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CommonText.semiBold(
                                    controller.data.name,
                                    size: 18,
                                  ),
                                ),
                                SvgImageFromAsset(AppCommonIcon.starIcon),
                                Gap(5),
                                CommonText.semiBold(
                                  controller.detail.value.courseRate.toString(),
                                  size: 18,
                                  color: AppColors.secondary500,
                                ),
                              ],
                            ),
                            Gap(12),
                            CommonText.regular(
                              controller.detail.value.description,
                              size: 14,
                              color:  isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                            ),
                            Gap(20),
                            CommonText.semiBold(
                              UniversityDetailViewStrings.availableCourses,
                              size: 18,
                            ),
                            Gap(20),
                            ListView.separated(
                              itemCount: controller.detail.value.availableCourseList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = controller.detail.value.availableCourseList[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRouteName.courseDetailView, arguments: data);
                                  },
                                  child: RelatedCoursesView(data: data),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12,top: 12),
                                  child: CommonDivider(),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
