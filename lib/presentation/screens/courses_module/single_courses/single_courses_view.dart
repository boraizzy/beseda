part of 'single_courses_imports.dart';

class SingleCoursesView extends StatefulWidget {
  const SingleCoursesView({super.key});

  @override
  State<SingleCoursesView> createState() => _SingleCoursesViewState();
}

class _SingleCoursesViewState extends State<SingleCoursesView> {
  SingleCoursesController controller = Get.put(SingleCoursesController());
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
            Padding(
              padding: const EdgeInsets.only(right: 17),
              child: CommonAppbar(
                title: controller.data.name,
                actionWidget: SizedBox(
                  width: 119,
                  child: PrimaryButton(
                    height: 30,
                    borderRadius: 3,
                    onPressed: () {
                      Get.toNamed(
                        AppRouteName.aiChatbotView,
                        arguments: controller.detail.value,
                      );

                    },
                    label: SingleCoursesStrings.chatWithTutor,
                    textSize: 14,
                  ),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: singleVideoPlayerView(),
            ),
            Gap(20),
            Expanded(
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                    ),
                    child: singleCourseView(),
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
