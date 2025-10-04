part of 'onboarding_imports.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return SafeArea(
      top: false,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDarkMode
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                itemCount: controller.onboardingData.length,
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final data = controller.onboardingData[index];
                  return Container(
                    height: context.height,
                    width: context.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(isDarkMode?OnboardingAssets.darkOnboardingBg:OnboardingAssets.onboardingBg),
                      ),
                    ),
                    child: OnboardingPage(
                      data.image,
                      data.title,
                      data.subtitle,
                    ),
                  );
                },
              ),
              Obx(() => controller.pageIndex.value==controller.onboardingData.length-1?SizedBox():
              Positioned(
                top: 50,
                right: 20,
                child: InkWell(
                  onTap:() {
                    Get.offNamed(AppRouteName.signInView);
                    AppSharedPreference.setFirstTimeOnboarding(false);
                  } ,
                  child: CommonText.medium(
                    AppCommonStrings.btnSkip,
                    size: 16,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                  ),
                ),
              ),),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Get.offNamed(AppRouteName.signUpView);
                          AppSharedPreference.setFirstTimeOnboarding(false);
                        },
                        label: AppCommonStrings.btnSignUp,
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
                          Get.offNamed(AppRouteName.signInView);
                          AppSharedPreference.setFirstTimeOnboarding(false);
                        },
                        label: AppCommonStrings.btnSignIn,
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
