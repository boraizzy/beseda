part of 'ai_learning_imports.dart';
class AiLearningView extends StatefulWidget {
  const AiLearningView({super.key});

  @override
  State<AiLearningView> createState() => _AiLearningViewState();
}

class _AiLearningViewState extends State<AiLearningView> {
  AiLearningController controller=Get.put(AiLearningController());
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CommonAppbar(title: AiLearningStrings.yourAiAssistant),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                          vertical: horizontalSpacing
                        ),
                        child: commonSeeAllText(
                          AiLearningStrings.suggestedCoursesForYou,
          
                          false,
                              () {},
                        ),
                      ),

                      Obx(
                            () => SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: controller.suggestedCoursesList.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                            ),
          
                            itemBuilder: (context, index) {
                              final data = controller.suggestedCoursesList[index];
          
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SuggestedCoursesView(
                                  data: data,
          
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(10),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          AiLearningStrings.personalizedCourses,
          
                          true,
                              () {},
                        ),
                      ),
          
                      Gap(17),
                      Obx(
                            () => SizedBox(
                          height: 225,
                          child: ListView.builder(
                            itemCount: controller.topRecommendedList.length,
                            scrollDirection: Axis.horizontal,
          
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                            ),
          
                            itemBuilder: (context, index) {
                              final data = controller.topRecommendedList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRouteName.courseDetailView,
                                      arguments: data,
                                    );
                                  },
                                  child: CommonCourseView(data: data),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: bannerView(),
                      ),
                      Gap(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          AiLearningStrings.smartRecommendation,
          
                          false,
                              () {},
                        ),
                      ),
                      Gap(17),
                      Obx(
                            () => SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: controller.topRatedList.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                            ),
          
                            itemBuilder: (context, index) {
                              final data = controller.topRatedList[index];
          
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SuggestedCoursesView(
                                  data: data,
          
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(20)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
  Widget bannerView() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouteName.aiChatbotView);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
            colors: [Color(0xff0D607D), Color(0xff30B2CE)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.semiBold(
                    AiLearningStrings.askAiTutor,
                    size: 20,
                    color: AppColors.white,
                  ),
                  Gap(5),
                  CommonText.regular(
                    AiLearningStrings.askAiTutorDes,
                    size: 12,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgImageFromAsset(
                  CommonImageAssets.rightArrowImg,
                  colorFilter: ColorFilter.mode(
                    AppColors.blueGradientColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
