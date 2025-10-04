part of 'feedback_submitted_imports.dart';

class FeedbackSubmittedView extends StatefulWidget {
  const FeedbackSubmittedView({super.key});

  @override
  State<FeedbackSubmittedView> createState() => _FeedbackSubmittedViewState();
}

class _FeedbackSubmittedViewState extends State<FeedbackSubmittedView> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(40),
                    Align(
                      alignment: Alignment.center,
                      child: SvgImageFromAsset(
                        CommonImageAssets.feedBackSubmitted,
                        height: 64,
                        width: 64,
                      ),
                    ),
                    Gap(35),
                    CommonText.medium(
                      FeedbackSubmittedStrings.feedbackSubmitted,
                      size: 24,
                    ),
                    Gap(12),
                    CommonText.regular(
                      FeedbackSubmittedStrings.feedbackHasBeenSubmitted,
                      size: 15,
                      color: isDarkMode
                          ? AppColors.bodyTextDarkColor
                          : AppColors.bodyTextColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: PrimaryButton(
                  onPressed: () {
                    Get.offNamedUntil(
                      AppRouteName.bottomView,
                      (route) => route.isFirst,
                    );
                  },
                  label: FeedbackSubmittedStrings.backToHome,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
