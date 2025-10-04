part of 'meeting_permission_imports.dart';

class MeetingPermissionView extends StatefulWidget {
  const MeetingPermissionView({super.key});

  @override
  State<MeetingPermissionView> createState() => _MeetingPermissionViewState();
}

class _MeetingPermissionViewState extends State<MeetingPermissionView> {
  MeetingPermissionController controller = Get.put(
    MeetingPermissionController(),
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
            children: [
              CommonAppbar(title: controller.title),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgImageFromAsset(CommonImageAssets.permissionLock),
                    Gap(15),
                    CommonText.semiBold(
                      MeetingPermissionStrings.enablePermission,
                      size: 20,
                      color: AppColors.primary500,
                    ),
                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CommonText.regular(
                        MeetingPermissionStrings.grantPermissionDes,
                        size: 16,
                        color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: PrimaryButton(onPressed: () {
                  Get.toNamed(AppRouteName.meetingJoiningView);

                }, label:    MeetingPermissionStrings.grantPermission, ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
