part of 'leave_session_confirmation_imports.dart';
class LeaveSessionConfirmationView extends StatefulWidget {
  const LeaveSessionConfirmationView({super.key});

  @override
  State<LeaveSessionConfirmationView> createState() => _LeaveSessionConfirmationViewState();
}

class _LeaveSessionConfirmationViewState extends State<LeaveSessionConfirmationView> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImageFromAsset(CommonImageAssets.hand),
                    CommonText.semiBold(
                      LeaveSessionString.youLeftTheSession,
                      size: 20,
                      color: AppColors.primary500,
                    ),
                    Gap(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                      child: CommonText.regular(
                        LeaveSessionString.youLeftTheSessionDes,
                        size: 15,
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
                padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Get.offNamedUntil(AppRouteName.bottomView,(route) => route.isFirst,);
                        },
                        label: PaymentViewStrings.goToHome,
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
                          Get.offNamedUntil(AppRouteName.meetingJoiningView,(route) => route.isFirst,);
                        },
                        label: LeaveSessionString.reJoin,
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
