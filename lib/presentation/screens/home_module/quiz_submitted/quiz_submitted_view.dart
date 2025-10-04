part of 'quiz_submitted_imports.dart';

class QuizSubmittedView extends StatefulWidget {
  const QuizSubmittedView({super.key});

  @override
  State<QuizSubmittedView> createState() => _QuizSubmittedViewState();
}

class _QuizSubmittedViewState extends State<QuizSubmittedView> {
  QuizSubmittedController controller = Get.put(QuizSubmittedController());

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
              // Padding(
              //   padding: const EdgeInsets.only(right: 5),
              //   child: CommonAppbar(title: controller.data!.name.isEmpty?'':controller.data!.name),
              // ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgImageFromAsset(CommonImageAssets.quizSubmitted),
                    Gap(12),
                    CommonText.semiBold(
                      QuizSubmittedStrings.quizCompleted,
                      size: 22,
                      color: AppColors.primary500,
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CommonText.regular(
                        QuizSubmittedStrings.quizCompletedDes,
                        size: 16,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            : AppColors.bodyTextColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRouteName.quizView,
                            arguments: {
                              'data': controller.data,
                              'list': controller.answerList,
                            },
                          );
                        },
                        label: QuizSubmittedStrings.viewAnswer,
                        borderSide: BorderSide(color: AppColors.primary500),
                        textColor: AppColors.primary500,
                        textSize: 16,
                        textWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(20),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.leaderBoardView);
                        },
                        label: QuizSubmittedStrings.viewLeaderBoard,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
