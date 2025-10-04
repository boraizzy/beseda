part of 'yet_to_start_imports.dart';

class YetToStartView extends StatefulWidget {
  const YetToStartView({super.key});

  @override
  State<YetToStartView> createState() => _YetToStartViewState();
}

class _YetToStartViewState extends State<YetToStartView> {
  YetToStartController controller=Get.put(YetToStartController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              Gap(80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgImageFromAsset(CommonImageAssets.generic),
                    SvgImageFromAsset(AppCommonIcon.volumeIcon),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
          
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary500,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgImageFromAsset(AppCommonIcon.meetingLoading),
                      ),
                    ),
                    Gap(20),
                    CommonText.semiBold(
                      YetToStartString.classYetToStart,
                      size: 20,
                      color: AppColors.primary500,
                    ),
                    CommonText.regular(
                      YetToStartString.sitBackAndRelax,
                      size: 16,
                      color: AppColors.bodyTextColor,
                    ),
          
                  ],
                ),
              ),
              commonBottomViewOfMeeting(() {
          
              },context)
            ],
          ),
        ),
      ),
    );
  }
}
