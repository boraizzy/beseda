part of 'video_to_text_imports.dart';

class VideoToTextView extends StatefulWidget {
  const VideoToTextView({super.key});

  @override
  State<VideoToTextView> createState() => _VideoToTextViewState();
}

class _VideoToTextViewState extends State<VideoToTextView> {
  VideoToTextController controller = Get.put(VideoToTextController());

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
            CommonAppbar(title: VideoToTextStrings.videoToText),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20),
                      CommonText.medium(VideoToTextStrings.translation, size: 18),
                      Gap(20),
                      Obx(
                        () => ListView.builder(
                          itemCount: controller.keyPointsList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            controller.globalTitle=controller.keyPointsList[index].title;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText.regular('${index + 1}.', size: 14),
                                  Expanded(
                                    child: CommonText.regular(
                                      controller.keyPointsList[index].title,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Gap(15),
                      CommonText.regular(
                        SummarizeVideoStrings.description,
                        size: 14,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            :AppColors.bodyTextColor,
                      ),
                      Gap(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonText.semiBold(
                              VideoToTextStrings.convertTextInto,
                              color: AppColors.primary500,
                              size: 16,
                              maxLines: 2,
                            ),
                          ),
                          Gap(3),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SvgImageFromAsset(AppCommonIcon.aiStarIcon),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 111,
                            child: PrimaryButton(
                              height: 32,
                              borderRadius: 4,
                              onPressed: () {
                                Get.toNamed(AppRouteName.textToVoiceView,arguments: controller.globalTitle);
                              },
                              label: SingleCoursesStrings.convert,
                              textSize: 13,
                            ),
                          ),
                        ],
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
