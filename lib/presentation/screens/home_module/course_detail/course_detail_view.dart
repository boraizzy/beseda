part of 'course_detail_imports.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({super.key});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView>
    with TickerProviderStateMixin {
  final CourseDetailController controller = Get.put(CourseDetailController());
  late TabController tabController;

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

    return Obx(
      () => PopScope(
        canPop: !controller.isFullScreen.value,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.isFullScreen.value) {
            controller.toggleFullScreen(); // exit fullscreen
          }
        },
        child: Scaffold(
          body: controller.isFullScreen.value
              ? videoPlayerView()
              : DefaultTabController(
                  length: 2,
                  child: Container(
                    height: context.height,
                    decoration: BoxDecoration(
                      gradient: isDarkMode
                          ? AppCommonGradient.mainDarkBackgroundGradient
                          : AppCommonGradient.mainBackgroundGradient,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CommonAppbar(title: controller.course.name),
                        ),
                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) {
                              return [
                                SliverToBoxAdapter(
                                  child: _courseHeaderView(context),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate: SliverTabBarDelegate(
                                    commonTabBar(
                                      tabController: tabController,
                                      firstTabTitle:
                                          CourseDetailStrings.curriculum,
                                      secondTabTitle:
                                          CourseDetailStrings.ratingReview,
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
                                children: const [
                                  CurriculumView(),
                                  RatingReview(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// ✅ Fixed: course header with image + title + description
  Widget _courseHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.course.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                controller.course.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            controller.course.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (controller.course.description != null)
            Text(
              controller.course.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
