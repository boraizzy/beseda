part of 'language_preference_imports.dart';

class LanguagePreferenceView extends StatefulWidget {
  const LanguagePreferenceView({super.key});

  @override
  State<LanguagePreferenceView> createState() => _LanguagePreferenceViewState();
}

class _LanguagePreferenceViewState extends State<LanguagePreferenceView> {
  LanguagePreferenceController controller = Get.put(
    LanguagePreferenceController(),
  );

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbar(title: SettingString.languagePreference),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: CommonText.semiBold(
                  LanguagePreferenceString.chooseLanguage,
                  size: 16,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: SafeArea(
                  child: ListView.separated(
                    itemCount: controller.languageList.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                    ),
                    itemBuilder: (context, index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            controller.languageSelection(index);
                          },
                          child: SizedBox(
                            height: 62,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText.medium(
                                  controller.languageList[index],
                                  size: 16,
                                  textAlign: TextAlign.start,
                                  color: isDarkMode
                                      ? AppColors.bodyTextDarkColor
                                      : AppColors.bodyTextColor,
                                ),
                                controller.selectedLanguage.value == index
                                    ? buildCheck()
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return CommonDivider();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: PrimaryButton(
                  onPressed: () {
                    Get.back();
                  },
                  label: LanguagePreferenceString.setLanguage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
