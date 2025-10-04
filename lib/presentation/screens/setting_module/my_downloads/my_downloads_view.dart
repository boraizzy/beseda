part of 'my_downloads_imports.dart';

class MyDownloadsView extends StatefulWidget {
  const MyDownloadsView({super.key});

  @override
  State<MyDownloadsView> createState() => _MyDownloadsViewState();
}

class _MyDownloadsViewState extends State<MyDownloadsView> {
  MyDownloadsController controller = Get.put(MyDownloadsController());
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
              controller.title.isNotEmpty?SizedBox():
              CommonAppbar(title: MyDownloadsString.myDownloads),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: Obx(
                  () =>  Row(
                    children: [
                      _commonButtons(
                        0,
                        '${MyDownloadsString.videoLectures} (${controller.videoLectureList.length})',
                      ),
                      Gap(7),
                      _commonButtons(
                        1,
                        '${MyDownloadsString.documents} (${controller.documentsList.length})',
                      ),
                      Gap(7),
                      _commonButtons(
                        2,
                        '${MyDownloadsString.audio} (${controller.audioList.length})',
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              Expanded(
                child: Obx(() {
                  return controller.selectedIndex.value == 0
                      ? _videoLectureList()
                      : controller.selectedIndex.value == 1
                      ? _documentList()
                      : _audioList();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _commonButtons(int index, String title) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Expanded(
      child: Obx(
        () => InkWell(
          onTap: () {
            controller.selection(index);
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? AppColors.primary500
                  : isDarkMode?AppColors.greyDarkColor:AppColors.greyBgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: CommonText.medium(
                title,
                size: 10,
                color: controller.selectedIndex.value == index
                    ? AppColors.white
                    : isDarkMode?AppColors.white:AppColors.headingsColor,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _videoLectureList() {
    const double horizontalSpacing = 20;
    return ListView.builder(
      itemCount: controller.videoLectureList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      itemBuilder: (context, index) {
        final data = controller.videoLectureList[index];
        return videoLectureView(data,context,index);
      },
    );
  }

  _documentList() {
    const double horizontalSpacing = 20;
    return ListView.builder(
      itemCount: controller.documentsList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      itemBuilder: (context, index) {
        final data = controller.documentsList[index];
        return documentView(data,context,index);
      },
    );
  }

  _audioList() {
    const double horizontalSpacing = 20;
    return ListView.builder(
      itemCount: controller.audioList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      itemBuilder: (context, index) {
        final data = controller.audioList[index];
        return audioView(data,context,index);
      },
    );
  }
}
