part of 'completed_test_imports.dart';

class CompletedTestView extends StatefulWidget {
  const CompletedTestView({super.key});

  @override
  State<CompletedTestView> createState() => _CompletedTestViewState();
}

class _CompletedTestViewState extends State<CompletedTestView> {
  CompletedTestController controller = Get.put(CompletedTestController());
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
              Expanded(
                child:
                    controller.correctAnswerCount == controller.totalQuestionCount
                    ? excellentView()
                    : controller.correctAnswerCount! >= 2
                    ? goodJobView()
                    : keepTryingView(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
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
                              'title': controller.title,
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
                          Get.toNamed(AppRouteName.feedbackView);
                        },
                        label: FeedbackStrings.feedback,
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
