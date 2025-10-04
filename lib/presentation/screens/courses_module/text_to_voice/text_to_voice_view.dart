part of 'text_to_voice_imports.dart';

class TextToVoiceView extends StatefulWidget {
  const TextToVoiceView({super.key});

  @override
  State<TextToVoiceView> createState() => _TextToVoiceViewState();
}

class _TextToVoiceViewState extends State<TextToVoiceView> {
  late FlutterTts flutterTts;
  TextToVoiceController controller = Get.put(TextToVoiceController());
  @override
  void initState() {
    super.initState();
    initTts();
  }

  void initTts() {
    flutterTts = FlutterTts();

    flutterTts.setCompletionHandler(() {
      controller.stopProgress();
    });

    flutterTts.setCancelHandler(() {
      controller.stopProgress();
    });
  }

  void _play() async {
    await flutterTts.speak(controller.getText);
    controller.startProgressTimer(() {
      flutterTts.stop();
    });
  }

  void _pause() async {
    await flutterTts.stop();
    controller.stopProgress();
  }

  String formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
    return DateFormat.ms().format(DateTime(0).add(d));
  }

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
              CommonAppbar(title: TextToVoiceStrings.textToVoice),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(30),
                        CommonText.medium(
                          TextToVoiceStrings.textToVoiceDes,
                          size: 17,
                        ),
                        Gap(20),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonText.medium(
                                '${formatDuration(controller.currentTime.value)}/${formatDuration(controller.totalDuration.value)}',
                                size: 14,
                              ),
                              Spacer(),
                              SvgImageFromAsset(
                                AppCommonIcon.downloadIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.primary500,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Gap(5),
                              SvgImageFromAsset(
                                AppCommonIcon.muteIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.primary500,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(25),
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode?AppColors.greyDarkColor:AppColors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.08),
                                blurRadius: 9,
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    controller.isPlaying.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 35,
                                    color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                                  ),
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      _pause();
                                    } else {
                                      _play();
                                    }
                                  },
                                ),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: controller.progress.value,
                                    minHeight: 5,
                                    backgroundColor: isDarkMode?AppColors.white:AppColors.background100,
                                    color: AppColors.primary500,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                Gap(15),
                              ],
                            ),
                          ),
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
