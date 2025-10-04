part of 'my_progress_imports.dart';

class MyProgressView extends StatefulWidget {
  const MyProgressView({super.key});

  @override
  State<MyProgressView> createState() => _MyProgressViewState();
}

class _MyProgressViewState extends State<MyProgressView> {
  MyProgressController controller = Get.put(MyProgressController());
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
              CommonAppbar(title: SettingString.myProgress),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(20),
                      rankView(),
                      // Stack(
                      //   clipBehavior: Clip.none,
                      //   children: [
                      //     SizedBox(
                      //       //height: 300,
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 20),
                      //         child:
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           children: [
                      //             Expanded(
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   commonView(
                      //                     image: AppCommonIcon.illustrationIcon,
                      //                     name: 'Illustration',
                      //                     courses: '05 Courses',
                      //                   ),
                      //                   Gap(10),
                      //                   commonContainer(height: 85, title: '2'),
                      //                 ],
                      //               ),
                      //             ),
                      //             Expanded(
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 children: [
                      //                   Image.asset(
                      //                     AppCommonIcon.uiUxIcon,
                      //                     height: 75,
                      //                     width: 75,
                      //                   ),
                      //                   Gap(10),
                      //                   CommonText.medium('UI/UX Design', size: 15),
                      //                   Gap(10),
                      //                   Container(
                      //                     height: 28,
                      //                     width: 96,
                      //
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primary500,
                      //                       borderRadius: BorderRadius.circular(27.6),
                      //                     ),
                      //                     child: Center(
                      //                       child: CommonText.medium(
                      //                         '02 Courses',
                      //                         size: 12,
                      //                         color: AppColors.white,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   Gap(10),
                      //                   commonContainer(height: 110, title: '1'),
                      //                 ],
                      //               ),
                      //             ),
                      //             Expanded(
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   commonView(
                      //                     image: AppCommonIcon.developmentIcon,
                      //                     name: 'Illustration',
                      //                     courses: '05 Courses',
                      //                   ),
                      //                   Gap(10),
                      //                   commonContainer(height: 85, title: '3'),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //
                      //
                      //       ),
                      //     ),
                      //     Positioned(
                      //       bottom: -50,
                      //       left: 0,
                      //       right: 0,
                      //       child: Stack(
                      //         children: [
                      //           SvgImageFromAsset(CommonImageAssets.leaderboardLineImg),
                      //           Positioned(
                      //             top: 20,
                      //             left: 50,
                      //             right: 50,
                      //             child: CircleAvatar(
                      //               radius: 4,
                      //               backgroundColor: AppColors.primary300,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Gap(5),
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.cardDarkBg2Color
                              : AppColors.cardBgColor,
                        ),
                        child: _courseListView(),
                      ),

                      Gap(25),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          '${HomeViewStrings.onGoingCourses} (${controller.detail.value.onGoingCoursesList.length})',
                          false,
                          () {},
                        ),
                      ),
                      Gap(25),
                      _ongoingCourseListView(),
                      Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          MyProgressString.achievements,
                          false,
                          () {},
                        ),
                      ),
                      Gap(25),
                      _achievementListView(),
                      Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          MyProgressString.pointsEarned,
                          false,
                          () {},
                        ),
                      ),
                      Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: pointsEarnedView(),
                      ),
                      Gap(25),
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

  Widget rankView() {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Obx(() {
      final rank1 = controller.detail.value.rankList.firstWhere(
        (e) => e.rank == 1,
      );
      final rank2 = controller.detail.value.rankList.firstWhere(
        (e) => e.rank == 2,
      );
      final rank3 = controller.detail.value.rankList.firstWhere(
        (e) => e.rank == 3,
      );
      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            //height: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Rank 2 → Left
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonView(
                          image: rank2.image,
                          name: rank2.title,
                          courses:
                              "${rank2.courses.toString().padLeft(2, '0')} Courses",
                        ),
                        Gap(15),
                        commonContainer(height: 85, title: '2'),
                      ],
                    ),
                  ),

                  // Rank 1 → Center (Taller)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isDarkMode
                            ? Image.asset(
                                CommonImageAssets.rankOneLogo,
                                height: 78,
                                width: 60,
                              )
                            : commonCacheImage(
                                rank1.image,
                                ImagePlaceHolder.imagePlaceHolderDark,
                                height: 78,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                        Gap(10),
                        CommonText.medium(rank1.title, size: 15),
                        Gap(10),
                        Container(
                          height: 28,
                          width: 96,

                          decoration: BoxDecoration(
                            color: AppColors.primary500,
                            borderRadius: BorderRadius.circular(27.6),
                          ),
                          child: Center(
                            child: CommonText.medium(
                              "${rank2.courses.toString().padLeft(2, '0')} Courses",
                              size: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Gap(15),
                        commonContainer(height: 110, title: '1'),
                      ],
                    ),
                  ),

                  // Rank 3 → Right
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonView(
                          image: rank3.image,
                          name: rank3.title,
                          courses:
                              "${rank3.courses.toString().padLeft(2, '0')} Courses",
                        ),
                        Gap(15),
                        commonContainer(height: 85, title: '3'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -55,
            left: 0,
            right: 0,
            child: SvgImageFromAsset(
              isDarkMode
                  ? CommonImageAssets.darkLeaderboardLineImg
                  : CommonImageAssets.leaderboardLineImg,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
        ],
      );
    });
  }

  _courseListView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => ListView.builder(
        itemCount: controller.detail.value.courseList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalSpacing,
          vertical: 20,
        ),
        itemBuilder: (context, index) {
          final data = controller.detail.value.courseList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: courseListView(data),
          );
        },
      ),
    );
  }

  _ongoingCourseListView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => ListView.builder(
        itemCount: controller.detail.value.onGoingCoursesList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final data = controller.detail.value.onGoingCoursesList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ongoingCourseListView(data),
          );
        },
      ),
    );
  }

  _achievementListView() {
    const double horizontalSpacing = 20;
    return Obx(
      () => ListView.builder(
        itemCount: controller.detail.value.achievementList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final data = controller.detail.value.achievementList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: achievementView(data),
          );
        },
      ),
    );
  }
}
