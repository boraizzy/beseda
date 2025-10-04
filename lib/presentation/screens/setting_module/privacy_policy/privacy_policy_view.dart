part of 'privacy_policy_imports.dart';
class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {

  final PrivacyPolicyController controller =
  Get.put(PrivacyPolicyController());

  final ScrollController _rrectController = ScrollController();
  @override
  Widget build(BuildContext context) {
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
              CommonAppbar(title: SettingString.privacyPolicy),
              
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: _rrectController,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: getFile(),
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
  Widget getFile() {
    return FutureBuilder<void>(
      future: controller.initWebView(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary500,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return WebViewWidget(controller: controller.webViewController);
        }
      },
    );
  }
}
