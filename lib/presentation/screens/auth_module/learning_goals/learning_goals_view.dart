part of 'learning_goals_imports.dart';

class LearningGoalsView extends StatefulWidget {
  const LearningGoalsView({super.key});

  @override
  State<LearningGoalsView> createState() => _LearningGoalsViewState();
}

class _LearningGoalsViewState extends State<LearningGoalsView> {
  LearningGoalsController controller = Get.put(LearningGoalsController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: commonCardDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackIcon(),
                      Gap(15),
                      Align(
                        alignment: Alignment.center,
                        child: CommonText.semiBold(
                          LearningGoalsStrings.setTourLearningGoals,
                          size: 24,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(50),
                      _commonView(0,CommonImageAssets.prepareExam,LearningGoalsStrings.prepareForExam),
                      Gap(15),
                      _commonView(1,CommonImageAssets.codingSkill,LearningGoalsStrings.improveMyCodingSkill),
                      Gap(15),
                      _commonView(2,CommonImageAssets.graduation,LearningGoalsStrings.updateForANewJob),
                    ],
                  ),
                ),
                PrimaryButton(
                  onPressed: () {
                    Get.toNamed(AppRouteName.skillLevelView);
                  },
                  label: AppCommonStrings.btnNext,
                ),
              ],
            ),
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          decoration: BoxDecoration(
            color: controller.selectedIndex.value == index
                ? isDarkMode?AppColors.cardDarkBgColor:AppColors.cardBgColor
                : Colors.transparent,
            border: Border.all(color:controller.selectedIndex.value == index
                ? AppColors.primary500
                : isDarkMode?AppColors.grey100Color:AppColors.greyColor,width: 1,

            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgImageFromAsset(image),
              Gap(10),

              CommonText.medium(title, size: 18, textAlign: TextAlign.center),
              Spacer(),
              controller.selectedIndex.value == index
                  ? SvgImageFromAsset(AppCommonIcon.checkIcon)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
