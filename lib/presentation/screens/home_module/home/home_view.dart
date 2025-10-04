part of 'home_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: commonAppBar(),
            ),
            Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _searchTextFiled(),
                    Gap(30),
                    _ongoingTitle(),
                    Gap(15),
                    _ongoingView(),
                    Gap(30),
                    _browseByCategoriesTitle(),
                    Gap(15),
                    _browseByCategoriesView(),
                    Gap(30),
                    _topRecommendedTitle(),
                    Gap(15),
                    _topRecommendedView(),
                    Gap(30),
                    _universityTitle(),
                    Gap(15),
                    _universityView(),
                    Gap(30),
                    _bannerOneView(),
                    Gap(30),
                    _bannerTwoView(),
                    Gap(30),
                    _mockTestTitle(),
                    Gap(15),
                    _mockTestView(),
                    Gap(50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchTextFiled() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: CommonSearchField(
        controller: controller.searchController,
        hintText: HomeViewStrings.searchAnything,
        focusNode: controller.searchFocusNode,
        onSearchTap: () {
          controller.navigateToSearchScreen();
        },
      ),
    );
  }

  _ongoingTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: commonSeeAllText(HomeViewStrings.onGoingCourses, false, () {}),
    );
  }

  _ongoingView() {
    return Obx(
      () => SizedBox(
        height: 160,
        child: ListView.builder(
          itemCount: controller.ongoingCoursesList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),

          itemBuilder: (context, index) {
            final data = controller.ongoingCoursesList[index];
            return ongoingCoursesView(data);
          },
        ),
      ),
    );
  }

  _browseByCategoriesTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: commonSeeAllText(HomeViewStrings.browseByCategories, true, () {
        Get.toNamed(
          AppRouteName.courseCategoryListView,
          arguments: controller.courseCategoryList,
        );
      }),
    );
  }

  _browseByCategoriesView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        child: browseByCategoriesView(),
      ),
    );
  }

  _universityTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: commonSeeAllText(HomeViewStrings.exclusiveUniversity, true, () {
        Get.toNamed(AppRouteName.allUniversityListView);
      }),
    );
  }

  _universityView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => SizedBox(
        height: 110,
        child: ListView.builder(
          itemCount: controller.universityList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),

          itemBuilder: (context, index) {
            final data = controller.universityList[index];
            return InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.universityDetailView, arguments: data);
              },
              child: universityView(data),
            );
          },
        ),
      ),
    );
  }

  _topRecommendedTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: commonSeeAllText(HomeViewStrings.topRecommendedCourse, true, () {
        Get.toNamed(
          AppRouteName.courseListingView,
          arguments: HomeViewStrings.topRecommendedCourse,
        );
      }),
    );
  }

  _topRecommendedView() {
    return Obx(
      () => SizedBox(
        height: 240,
        child: ListView.builder(
          itemCount: controller.topRecommendedList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),
          itemBuilder: (context, index) {
            final data = controller.topRecommendedList[index];
            return InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.courseDetailView, arguments: data);
              },
              child: CommonCourseView(
                data: data,
                wishlistOnTap: () {
                  final wishlistController = Get.find<WishlistController>();
                  wishlistController.toggleWishlist(data);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _bannerOneView() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: bannerOne(),
    );
  }

  _topRatedTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: commonSeeAllText(HomeViewStrings.topRatedCourses, true, () {
        Get.toNamed(
          AppRouteName.courseListingView,
          arguments: HomeViewStrings.topRatedCourses,
        );
      }),
    );
  }

  _topRatedView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => SizedBox(
        height: 225,
        child: ListView.builder(
          itemCount: controller.topRatedList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),

          itemBuilder: (context, index) {
            final data = controller.topRatedList[index];
            return InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.courseDetailView, arguments: data);
              },
              child: CommonCourseView(
                data: data,
                wishlistOnTap: () {
                  final wishlistController = Get.find<WishlistController>();
                  wishlistController.toggleWishlist(data);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _bannerTwoView() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.aiChatbotView);
        },
        child: bannerTwo(),
      ),
    );
  }

  _mockTestTitle() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: Row(
        children: [
          CommonText.semiBold(
            HomeViewStrings.simulateTheExam,
            size: 16,
            height: 1.0,
            letterSpacing: 0.0,
            textAlign: TextAlign.center,
          ),
          Gap(3),
          CommonText.semiBold(
            HomeViewStrings.mockTest,
            size: 16,
            height: 1.0,
            letterSpacing: 0.0,
            textAlign: TextAlign.center,
            color: AppColors.primary500,
          ),
        ],
      ),
    );
  }

  _mockTestView() {
    return Obx(
      () => SizedBox(
        height: 225,
        child: ListView.builder(
          itemCount: controller.mockTestList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),
          itemBuilder: (context, index) {
            final data = controller.mockTestList[index];
            return mockTestView(data);
          },
        ),
      ),
    );
  }
}
