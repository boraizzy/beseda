part of 'my_profile_imports.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView>
    with TickerProviderStateMixin {
  MyProfileController controller = Get.put(MyProfileController());
  MyCoursesController myCoursesController = Get.put(MyCoursesController());
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            Get.isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: myProfileAppBar(),
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? AppCommonGradient.mainDarkBackgroundGradient
                : AppCommonGradient.mainBackgroundGradient,
          ),
          child: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(child: headerView()),

                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverTabBarDelegate(
                          commonTabBar(
                            tabController: tabController,
                            firstTabTitle: HomeViewStrings.completed,
                            secondTabTitle: MyProfileViewStrings.onGoing,
                          ),
                          backgroundColor: isDarkMode
                              ? AppColors.mainDarkBgColor
                              : AppColors.white,
                        ),
                      ),
                    ];
                  },
                  body: SafeArea(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // ✅ Completed Courses
                        // ✅ Completed Courses
                        Obx(
                          () {
                            final completed = myCoursesController.myCoursesList
                                .where((c) => c.status == "Completed")
                                .toList();

                            if (completed.isEmpty) {
                              return Center(
                                child: commonEmptyView(
                                  image: isDarkMode
                                      ? CommonImageAssets.darkEmptyWishlist
                                      : CommonImageAssets.emptyWishlistView,
                                  title: "Нямате завършени курсове",
                                  subtitle: "Когато завършите курс, той ще се появи тук.",
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: completed.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalSpacing,
                                vertical: horizontalSpacing,
                              ),
                              itemBuilder: (context, index) {
                                return coursesView(completed[index]);
                              },
                            );
                          },
                        ),

                        // ✅ In Progress Courses
                        Obx(
                          () {
                            final inProgress = myCoursesController.myCoursesList
                                .where((c) => c.status == "In Progress")
                                .toList();

                            if (inProgress.isEmpty) {
                              return Center(
                                child: commonEmptyView(
                                  image: isDarkMode
                                      ? CommonImageAssets.darkEmptyWishlist
                                      : CommonImageAssets.emptyWishlistView,
                                  title: "Нямате курсове в процес",
                                  subtitle: "Когато започнете курс, той ще се появи тук.",
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: inProgress.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalSpacing,
                                vertical: horizontalSpacing,
                              ),
                              itemBuilder: (context, index) {
                                return coursesView(inProgress[index]);
                              },
                            );
                          },
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

Widget headerView() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  MyProfileController controller = Get.find<MyProfileController>();
  MyCoursesController myCoursesController = Get.find<MyCoursesController>();

  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: SizedBox(
      height: 360,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 290,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff375EDF), Color(0xff269BE0)],
              ),
            ),
            child: Obx(
              () => Center(
                child: Column(
                  children: [
                Gap(12),
                InkWell(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      final file = File(pickedFile.path);
                      await controller.updateProfileImage(file);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50), // ✅ make it round
                    child: InkWell(
                      onTap: () async {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(source: ImageSource.gallery);

                        if (picked != null) {
                          final file = File(picked.path);
                          await controller.updateProfileImage(file);
                        }
                      },
                      child: ClipOval(
                        child: commonCacheImage(
                          controller.userData.value.profileUrl,
                          UserPlaceholderAssets.userPlaceHolderLight,
                          fit: BoxFit.cover,
                          height: 72,
                          width: 72,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(15),
                CommonText.semiBold(
                  controller.userData.value.name,
                  size: 20,
                  textAlign: TextAlign.center,
                  color: AppColors.white,
                ),
                Gap(7),
                CommonText.light(
                  controller.userData.value.email,
                  size: 14,
                  textAlign: TextAlign.center,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
      ),

// Stats box
Positioned(
  bottom: 0,
  left: 25,
  right: 25,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: isDarkMode
        ? AppCommonShadow.commonDarkBoxShadow
        : AppCommonShadow.commonBoxShadow,
    child: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( // ✅ first column takes half width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                courseDetail(
                  AppColors.cardBgColor,
                  isDarkMode ? AppColors.primary300 : AppColors.primary500,
                  AppColors.primary300,
                  myCoursesController.myCoursesList.length.toString(),
                  MyProfileViewStrings.courseEnrolled,
                  CommonImageAssets.courseEnrolled,
                ),
                const Gap(20),
                courseDetail(
                  AppColors.success50,
                  isDarkMode ? AppColors.success300 : AppColors.success500,
                  AppColors.success300,
                  "Идва скоро",
                  MyProfileViewStrings.daysInLearning,
                  CommonImageAssets.calender,
                ),
              ],
            ),
          ),
          Expanded( // ✅ second column takes other half
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                courseDetail(
                  AppColors.secondary50,
                  isDarkMode ? AppColors.secondary300 : AppColors.secondary500,
                  AppColors.secondary300,
                  "Идва скоро",
                  MyProfileViewStrings.averageScore,
                  CommonImageAssets.averageScore,
                ),
                const Gap(20),
                courseDetail(
                  AppColors.error50,
                  isDarkMode ? AppColors.error300 : AppColors.error500,
                  AppColors.error300,
                  "Идва скоро",
                  MyProfileViewStrings.totalCoins,
                  CommonImageAssets.coins,
                ),
              ],
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
  );
}
