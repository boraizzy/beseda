part of 'feedback_imports.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  FeedbackController controller = Get.put(FeedbackController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              CommonAppbar(title: FeedbackStrings.feedback),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(40),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            CommonImageAssets.starStuck,
                            height: 64,
                            width: 64,
                          ),
                        ),
                        Gap(35),
                        RatingBar(
                          size: 36,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: 0,
                          alignment: Alignment.center,
                          onRatingChanged: (value) {},
                          filledColor: AppColors.secondary500,
                          emptyColor: AppColors.greyTextColor,
                        ),
                        Gap(60),
                        CommonText.semiBold(
                          FeedbackStrings.yourFeedback,
                          size: 18,
                        ),
                        Gap(12),
                        CommonText.regular(
                          FeedbackStrings.yourFeedbackDes,
                          size: 14,
                          color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                        ),
                        Gap(30),
                        CommonTextField(
                          contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 0),
                          controller: controller.textController,
                          textInputAction: TextInputAction.send,
                          hintText: FeedbackStrings.shareYourThoughts,
                          fillColor: Colors.transparent,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: PrimaryButton(
                  onPressed: () {
                    Get.toNamed(AppRouteName.feedbackSubmittedView);
                  },
                  label: FeedbackStrings.sendFeedBack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
