part of 'meeting_joining_imports.dart';

class MeetingJoiningView extends StatefulWidget {
  const MeetingJoiningView({super.key});

  @override
  State<MeetingJoiningView> createState() => _MeetingJoiningViewState();
}

class _MeetingJoiningViewState extends State<MeetingJoiningView> {
  MeetingJoiningController controller = Get.put(MeetingJoiningController());
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(30),
                      SvgImageFromAsset(CommonImageAssets.generic),
                      Gap(25),
                      CommonText.semiBold(
                        AppCommonStrings.btnGetStarted,
                        size: 20,
                        color: AppColors.primary500,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CommonText.regular(
                          MeetingJoiningStrings.setUpAudio,
                          size: 16,
                          color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                        ),
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 76,
                            decoration: BoxDecoration(
                              color: AppColors.error500,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: AppColors.white,
                                ),
                                Gap(5),
                                CommonText.semiBold(
                                  MeetingJoiningStrings.live,
                                  size: 14,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 166,
                            child: PrimaryButton(
                              height: 40,
                              borderRadius: 20,
                              onPressed: () {},
                              label: MeetingJoiningStrings.peopleInSession,
                              textSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Gap(90),
                      Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(color: AppColors.primary500,shape: BoxShape.circle),
                        child: Center(
                          child: CommonText.semiBold(
                            'KA',
                            size: 32,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:isDarkMode?AppCommonShadow.commonMeetingDarkBoxShadow:AppCommonShadow.commonMeetingBoxShadow,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing,vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Row(
                        children: [
                          SvgImageFromAsset(AppCommonIcon.muteMiceIcon),
                          Gap(15),
                          SvgImageFromAsset(AppCommonIcon.muteVideoIcon),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary500,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(child: SvgImageFromAsset(AppCommonIcon.muteIcon)),
                          ),
                        ],
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              controller: controller.textController,
                              focusNode: controller.focusNode,
                              textInputAction: TextInputAction.send,
                              hintText: MeetingJoiningStrings.enterName,
                              fillColor: Colors.transparent,
                            ),
                          ),
                          Gap(10),
                          SizedBox(
                            width: 92,
                            child: PrimaryButton(
                              onPressed: () {
                                Get.toNamed(AppRouteName.yetToStartView);
                              },
                              label: MeetingJoiningStrings.joinNow,
                            ),
                          ),
                        ],
                      ),
                    ],
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
