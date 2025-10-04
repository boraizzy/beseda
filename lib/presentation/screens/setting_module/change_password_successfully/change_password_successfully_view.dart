part of 'change_password_successfully_imports.dart';

class ChangePasswordSuccessfullyView extends StatefulWidget {
  const ChangePasswordSuccessfullyView({super.key});

  @override
  State<ChangePasswordSuccessfullyView> createState() =>
      _ChangePasswordSuccessfullyViewState();
}

class _ChangePasswordSuccessfullyViewState
    extends State<ChangePasswordSuccessfullyView> {
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
          minimum: EdgeInsets.symmetric(horizontal: horizontalSpacing),
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
                      ChangePasswordSuccessfullyString
                          .passwordChangedSuccessfully,
                      size: 20,
                    ),
                    Gap(12),
                    CommonText.regular(
                      ChangePasswordSuccessfullyString
                          .passwordChangedSuccessfullyDes,
                      size: 15,
                      color: isDarkMode
                          ? AppColors.bodyTextDarkColor
                          : AppColors.bodyTextColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                onPressed: () {
                  Get.offNamedUntil(
                    AppRouteName.bottomView,
                    (route) => route.isFirst,
                  );
                },
                label: FeedbackSubmittedStrings.backToHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
