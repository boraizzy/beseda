part of 'reset_password_successfully_imports.dart';
class ResetPasswordSuccessfullyView extends StatefulWidget {
  const ResetPasswordSuccessfullyView({super.key});

  @override
  State<ResetPasswordSuccessfullyView> createState() => _ResetPasswordSuccessfullyViewState();
}

class _ResetPasswordSuccessfullyViewState extends State<ResetPasswordSuccessfullyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: commonGradiantDecoration(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(50),
                    SvgImageFromAsset(CommonImageAssets.resetPasswordSuccessfully),
                    Gap(45),
                    CommonText.semiBold(
                      ResetPasswordSuccessfullyStrings.congratulations,
                      size: 22,
                      color: AppColors.success600,
                      textAlign: TextAlign.center,
                    
                    ),
                    Gap(10),
                    authSubTitleHeader(ResetPasswordSuccessfullyStrings.congratulationsDes),
                    Gap(40),
                  ],
                ),
              ),
              PrimaryButton(
                onPressed: () {
                  Get.offAllNamed(AppRouteName.signInView,);
                  },
                label: ResetPasswordSuccessfullyStrings.goToSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
