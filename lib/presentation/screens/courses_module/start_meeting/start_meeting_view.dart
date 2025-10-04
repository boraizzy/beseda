part of 'start_meeting_imports.dart';

class StartMeetingView extends StatefulWidget {
  const StartMeetingView({super.key});

  @override
  State<StartMeetingView> createState() => _StartMeetingViewState();
}

class _StartMeetingViewState extends State<StartMeetingView> {
  StartMeetingController controller = Get.put(StartMeetingController());
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
            Gap(80),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: liveSessionView(),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.usersList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = controller.usersList[index];
                    return Obx(
                      () =>  Container(
                        margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: controller. handsUp.value&&data.name=='Mathew'? AppColors.primary500:Colors.transparent,width: 4)
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: commonCacheImage(
                                data.image,
                                ImagePlaceHolder.imagePlaceHolderDark,
                                fit: BoxFit.cover,
                                height: 289,
                                width: double.infinity,
                              ),
                            ),
                           controller. handsUp.value&&data.name=='Mathew'? Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.primary500,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgImageFromAsset(
                                    AppCommonIcon.handsUpIcon,
                                  ),
                                ),
                              ),
                            ):
                           SizedBox(),
                            controller. handsUp.value&&data.name=='Mathew'?  Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                height: 32,
                                padding: EdgeInsets.symmetric(horizontal: 12),

                                decoration: BoxDecoration(
                                  color: AppColors.black.withValues(alpha: 0.64),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    SvgImageFromAsset(AppCommonIcon.pinIcon),
                                    Gap(10),
                                    CommonText.regular(
                                      data.name,
                                      size: 14,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ): SizedBox(),
                            controller. handsUp.value&&data.name=='Mathew'?  Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                height: 28,
                                width: 28,

                                decoration: BoxDecoration(
                                  color: AppColors.black.withValues(alpha: 0.64),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.more_vert,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ):SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            commonBottomViewOfMeeting(() {
              controller.handsUpOrNot();
            },context),

          ],
        ),
      ),
    );
  }
}
