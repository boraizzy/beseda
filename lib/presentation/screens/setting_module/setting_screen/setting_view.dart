part of 'setting_view_imports.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  SettingViewController controller = Get.put(SettingViewController());
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
        child: Column(
          children: [
            Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: commonAppBar(),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalSpacing,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [

                      Gap(20),
                      commonView(
                        image: CommonImageAssets.changePassword,
                        title: SettingString.changePassword,
                        onTap: () {
                          Get.toNamed(AppRouteName.changePasswordView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),

                      Gap(20),
                      commonView(
                        image: CommonImageAssets.aiChatbot,
                        title: SettingString.aiChatbot,
                        onTap: () {
                          Get.toNamed(AppRouteName.aiChatbotView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),
                      //dark mode
                      Gap(20),
                      Row(
                        children: [
                          SvgImageFromAsset(CommonImageAssets.darkMode),
                          Gap(10),
                          Expanded(
                            child: CommonText.medium(
                              SettingString.darkMode,
                              size: 16,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: CupertinoSwitch(
                              value: controller.isDarkMode.value,
                              onChanged: (value) {
                                controller.isDarkMode.value = value;

                                Get.find<ThemeController>().toggleTheme();
                                Get.forceAppUpdate();
                              },
                              activeTrackColor: AppColors.primary500,
                              thumbColor: AppColors.white,
                              inactiveThumbColor: AppColors.white,
                              inactiveTrackColor: AppColors.background100,
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      CommonDivider(),
                      Gap(20),
                      commonView(
                        image: CommonImageAssets.myProgress,
                        title: SettingString.myProgress,
                        onTap: () {
                          Get.toNamed(AppRouteName.myProgressView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),

                      Gap(20),
                      commonView(
                        image: CommonImageAssets.settingLeaderBoard,
                        title: LeaderBoardStrings.leaderBoard,
                        onTap: () {
                          Get.toNamed(AppRouteName.leaderBoardView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),

                      Gap(20),
                      commonView(
                        image: CommonImageAssets.faq,
                        title: SettingString.faq,
                        onTap: () {
                          Get.toNamed(AppRouteName.faqView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),
                      Gap(20),
                      commonView(
                        image: CommonImageAssets.contactUs,
                        title: SettingString.contactUs,
                        onTap: () {
                          Get.toNamed(AppRouteName.contactUsView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),
                      Gap(20),
                      commonView(
                        image: CommonImageAssets.privacyPolicy,
                        title: SettingString.privacyPolicy,
                        onTap: () {
                          Get.toNamed(AppRouteName.privacyPolicyView);
                        },
                      ),
                      Gap(20),
                      CommonDivider(),
                      Gap(20),
                      commonView(
                        image: CommonImageAssets.logOut,
                        title: SettingString.logout,
                        onTap: () {
                          commonDialog(context: context, view: logOutView());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
