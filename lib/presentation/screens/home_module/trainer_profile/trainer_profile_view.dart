part of 'trainer_profile_imports.dart';

class TrainerProfileView extends StatefulWidget {
  const TrainerProfileView({super.key});

  @override
  State<TrainerProfileView> createState() => _TrainerProfileViewState();
}

class _TrainerProfileViewState extends State<TrainerProfileView>
    with TickerProviderStateMixin {
  late TabController tabController;
  TrainerProfileController controller = Get.put(TrainerProfileController());
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: DefaultTabController(
        length: 2, // number of tabs
        child: Container(
          height: context.height,
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? AppCommonGradient.mainDarkBackgroundGradient
                : AppCommonGradient.mainBackgroundGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CommonAppbar(title: controller.data.name),
              ),

              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: trainerProfileView(),
                      ),

                      Obx(
                      ()=> SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverTabBarDelegate(
                            commonTabBar(
                              tabController: tabController,
                              firstTabTitle: TrainerProfileDetailStrings.about,
                              secondTabTitle: '${BottomViewStrings.myCourses}(${controller.detail.value.myCoursesList.length})',
                            ),

                            backgroundColor: isDarkMode
                                ? AppColors.mainDarkBgColor
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: tabController,
                    children: [AboutView(), MyCoursesViewList()],
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
