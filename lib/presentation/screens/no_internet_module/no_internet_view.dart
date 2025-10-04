part of 'no_internet_view_imports.dart';

class NoInternetView extends StatefulWidget {
  const NoInternetView({super.key});

  @override
  State<NoInternetView> createState() => _NoInternetViewState();
}

class _NoInternetViewState extends State<NoInternetView> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgImageFromAsset(CommonImageAssets.noInternet),
                      Gap(15),
                      CommonText.semiBold(ConnectionStrings.noConnection, size: 18),
                      Gap(5),
                      CommonText.regular(
                        ConnectionStrings.noInternetFound,
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
                    Get.offNamed(AppRouteName.myDownloadsView,arguments: 'No Internet');
                  },
                  label: ConnectionStrings.goToDownloads,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
