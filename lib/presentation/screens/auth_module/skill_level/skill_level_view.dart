part of 'skill_level_imports.dart';

class SkillLevelView extends StatefulWidget {
  const SkillLevelView({super.key});

  @override
  State<SkillLevelView> createState() => _SkillLevelViewState();
}

class _SkillLevelViewState extends State<SkillLevelView> {
  SkillLevelController controller = Get.put(SkillLevelController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:commonCardDecoration(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackIcon(),
              Gap(15),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CommonText.semiBold(
                            SkillLevelStrings.whoAreYou,
                            size: 24,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gap(50),
                        _commonView(
                          0,
                          CommonImageAssets.beginnerImg,
                          SkillLevelStrings.beginner,
                        ),
                        Gap(20),
                        _commonView(
                          1,
                          CommonImageAssets.intermediateImg,
                          SkillLevelStrings.intermediate,
                        ),
                        Gap(20),
                        _commonView(
                          2,
                          CommonImageAssets.advancedImg,
                          SkillLevelStrings.advanced,
                        ),
                        Gap(30),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,),
                child: PrimaryButton(
                  onPressed: () {
                    Get.offNamedUntil(AppRouteName.bottomView,(route) => route.isFirst,);
                  },
                  label: SkillLevelStrings.iAmReadyToLearn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _commonView(int index, String image, title) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Obx(
      () => InkWell(
        onTap: () {
          controller.selection(index);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: controller.selectedIndex.value == index
                    ? isDarkMode?AppColors.cardDarkBgColor:AppColors.cardBgColor
                    : Colors.transparent,
                border: Border.all(
                  color: controller.selectedIndex.value == index
                      ? AppColors.primary500
                      : AppColors.greyColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgImageFromAsset(image),
            ),
            Gap(10),
            CommonText.semiBold(
              title,
              size: 16,
              textAlign: TextAlign.center,
              color: controller.selectedIndex.value == index
                  ? AppColors.primary500
                  :isDarkMode?AppColors.headingsLightColor: AppColors.headingsColor,
            ),
          ],
        ),
      ),
    );
  }
}
