part of 'quiz_list_imports.dart';

class QuizListView extends StatefulWidget {
  const QuizListView({super.key});

  @override
  State<QuizListView> createState() => _QuizListViewState();
}

class _QuizListViewState extends State<QuizListView> {
  QuizListController controller = Get.put(QuizListController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: GetBuilder<QuizListController>(
        init: controller,
        tag: 'quiz_view',
        builder: (controller) {
          return Container(
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
                    child: CommonAppbar(title: QuizListStrings.quiz),
                  ),
                  SizedBox(
                    height: 55,
                    child: Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 15,
                        ),
                        itemCount: controller.allCourseCategoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: () {
                                controller.selection(index);
                                controller.fetchQuizById(
                                  controller.allCourseCategoryList[index].id,
                                );
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == index
                                      ? AppColors.primary500
                                      : isDarkMode
                                      ? AppColors.greyDarkColor
                                      : AppColors.greyBgColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: controller.selectedIndex.value == index
                                      ? CommonText.semiBold(
                                          controller
                                              .allCourseCategoryList[index]
                                              .name,
                                          size: 13,
                                          color: AppColors.white,
                                        )
                                      : CommonText.medium(
                                          controller
                                              .allCourseCategoryList[index]
                                              .name,
                                          size: 13,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              
                  Obx(() {
                    if (controller.quizList.isEmpty) {
                      return const Expanded(
                        child: Center(child: Text('No Data Available')),
                      );
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: controller.quizList.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalSpacing,
                            vertical: 30,
                          ),
                          itemBuilder: (context, index) {
                            final detail = controller.quizList[index];
                            return InkWell(
                              onTap: () {
                                controller.quizSelection(index);
                                Get.toNamed(
                                  AppRouteName.quizView,
                                  arguments: {'data': controller.quizList[index]},
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    detail.image, // make sure this is the path to your asset, e.g. "assets/images/quiz1.png"
                                    fit: BoxFit.contain,
                                    height: 64,
                                    width: 64,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText.semiBold(
                                          detail.name,
                                          size: 16,
                                        ),
                                        CommonText.regular(
                                          '${detail.noOfQuestions} Questions',
                                          size: 13,
                                          color: isDarkMode
                                              ? AppColors.bodyTextDarkColor
                                              : AppColors.bodyTextColor,
                                        ),
                                        CommonText.regular(
                                          '${detail.noOfAttendance} Attendance',
                                          size: 12,
                                          color: isDarkMode
                                              ? AppColors.greyTextDarkColor
                                              : AppColors.greyTextColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  controller.selectedQuizIndex.value == index
                                      ? buildCheck()
                                      : CircleAvatar(
                                          backgroundColor: isDarkMode
                                              ? AppColors.primary500
                                              : AppColors.background100,
                                          radius: 18,
                                          child: SvgImageFromAsset(
                                            AppCommonIcon.rightArrowIcon,
                                            height: 22,
                                            width: 22,
                                            colorFilter: ColorFilter.mode(
                                              isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.primary500,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: CommonDivider(),
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
