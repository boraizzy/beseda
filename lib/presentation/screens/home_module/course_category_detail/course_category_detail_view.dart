part of 'course_category_detail_imports.dart';

class CourseCategoryDetailView extends StatefulWidget {
  const CourseCategoryDetailView({super.key});

  @override
  State<CourseCategoryDetailView> createState() =>
      _CourseCategoryDetailViewState();
}

class _CourseCategoryDetailViewState extends State<CourseCategoryDetailView> {
  CourseCategoryDetailController controller = Get.put(
    CourseCategoryDetailController(),
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
              CommonAppbar(title: controller.category.name),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                          vertical: horizontalSpacing
                        ),
                        child: commonSeeAllText(
                          CourseCategoryDetailStrings.courseToGetStarted,
                
                          true,
                          () {
                            Get.toNamed(
                              AppRouteName.courseListingView,
                              arguments: CourseCategoryDetailStrings
                                  .courseToGetStarted,
                            );
                          },
                        ),
                      ),
                      Gap(15),
                      Obx(
                        () => SizedBox(
                          height: 240,
                          child: ListView.builder(
                            itemCount:
                                controller.courseData.value.courseList.length,
                            scrollDirection: Axis.horizontal,
                
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                            ),
                
                            itemBuilder: (context, index) {
                              final data =
                                  controller.courseData.value.courseList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRouteName.courseDetailView, arguments: data);
                                    },
                                    child: CommonCourseView(data: data)),
                              );
                            },
                          ),
                        ),
                      ),
                
                      Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          '${CourseCategoryDetailStrings.topInstructor} ${controller.category.name}',
                          false,
                          () {},
                        ),
                      ),
                
                      Gap(15),
                      Obx(
                        () => ListView.builder(
                          itemCount:
                              controller.courseData.value.instructorList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalSpacing,
                          ),
                          itemBuilder: (context, index) {
                            final data = controller
                                .courseData
                                .value
                                .instructorList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRouteName.trainerProfileView,
                                    arguments: data,
                                  );
                                },
                                child: Row(
                                  children: [
                                    commonCacheImage(
                                      data.image,
                                      UserPlaceholderAssets
                                          .userPlaceHolderLight,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                    Gap(10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText.semiBold(
                                          data.name,
                                          size: 16,
                                        ),
                                        CommonText.regular(
                                          data.qualification,
                                          size: 14,
                                          color: isDarkMode
                                              ? AppColors.bodyTextDarkColor
                                              : AppColors.bodyTextColor,
                                        ),
                                        CommonText.regular(
                                          '${data.noOfStudents.toString()} Students',
                                          size: 14,
                                          color: isDarkMode
                                              ? AppColors.greyTextDarkColor
                                              : AppColors.greyTextColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
