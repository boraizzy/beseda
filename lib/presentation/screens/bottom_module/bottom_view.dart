part of 'bottom_view_imports.dart';

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  BottomViewState createState() => BottomViewState();
}

class BottomViewState extends State<BottomView> with TickerProviderStateMixin {
  BottomViewController controller = Get.put(BottomViewController());
  late TabController tabController;

  late Worker tabListener;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    tabListener = ever(controller.selectedIndex, (index) {
      // Check if controller is mounted
      if (tabController.index != controller.selectedIndex.value) {
        tabController.animateTo(controller.selectedIndex.value);
      }
    });
  }

  @override
  void dispose() {
    tabListener.dispose(); // cancel the ever listener
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;


    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeView(),
          MyCoursesView(),
          WishlistView(),
          SettingView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavyBar(
          backgroundColor: isDarkMode
              ? AppColors.cardDarkBgColor
              : AppColors.mainBgColor,
          selectedIndex: controller.selectedIndex.value,
          showElevation: true,
          itemCornerRadius: 50,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            controller.selectedIndex.value = index;
          },
          items: <BottomNavyBarItem>[
            bottomView(
              AppCommonIcon.activeHomeIcon,
              AppCommonIcon.homeIcon,
              BottomViewStrings.home,
              0,
            ),
            bottomView(
              AppCommonIcon.activeCoursesIcon,
              AppCommonIcon.coursesIcon,
              BottomViewStrings.myCourses,
              1,
            ),
            bottomView(
              AppCommonIcon.activeWishlistIcon,
              AppCommonIcon.wishlistIcon,
              BottomViewStrings.wishlist,
              2,
            ),
            bottomView(
              AppCommonIcon.activeSettingIcon,
              AppCommonIcon.settingIcon,
              BottomViewStrings.setting,
              3,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavyBarItem bottomView(String activeImg, image, title, int index) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return BottomNavyBarItem(
      icon: SvgImageFromAsset(
        index == controller.selectedIndex.value ? activeImg : image,
        colorFilter: ColorFilter.mode(
          index == controller.selectedIndex.value
              ? isDarkMode
                    ? AppColors.white
                    : AppColors.primary500
              : AppColors.greyColor,
          BlendMode.srcIn,
        ),
      ),
      inactiveColor: AppColors.greyColor,
      title: CommonText.semiBold(
        title,
        size: 13,
        height: 1.0,
        letterSpacing: 0.0,
        textAlign: TextAlign.center,
        color: isDarkMode ? AppColors.white : AppColors.primary500,
      ),
      //activeColor:isDarkMode?AppColors.white: AppColors.primary500,
      textAlign: TextAlign.center,
      activeBackgroundColor: isDarkMode
          ? AppColors.primary500
          : AppColors.cardBgColor,

      //activeColor: Colors.yellow
    );
  }
}
