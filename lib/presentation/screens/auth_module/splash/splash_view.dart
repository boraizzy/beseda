part of 'splash_imports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      const splashStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );

      SystemChrome.setSystemUIOverlayStyle(splashStyle);
      debugPrint("🔵 SplashView: System UI style applied: $splashStyle");
    });
  }

  SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.splashDarkGradient
              : AppCommonGradient.splashGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgImageFromAsset(AppLogo.appLogo, height: 70, width: 70),
            Gap(20),
            CommonText.bold(
              AppStrings.appName,
              size: 20,
              height: 1.0,
              letterSpacing: 0.0,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
