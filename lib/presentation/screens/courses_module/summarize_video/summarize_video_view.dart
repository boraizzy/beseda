part of 'summarize_video_imports.dart';

class SummarizeVideoView extends StatefulWidget {
  const SummarizeVideoView({super.key});

  @override
  State<SummarizeVideoView> createState() => _SummarizeVideoViewState();
}

class _SummarizeVideoViewState extends State<SummarizeVideoView> {
  SummarizeVideoController controller = Get.put(SummarizeVideoController());

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
            children: [
              CommonAppbar(title: SummarizeVideoStrings.summarizeVideoKeyPoints),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        CommonText.medium(
                          SummarizeVideoStrings.keyPoints,
                          size: 18,
                        ),
                        Gap(20),
                        Obx(
                          () => ListView.builder(
                            itemCount: controller.keyPointsList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
