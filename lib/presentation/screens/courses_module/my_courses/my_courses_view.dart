part of 'my_courses_imports.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  MyCoursesController controller = Get.put(MyCoursesController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      // appBar: CommonAppbar(
      //   isAvailableSwitch: true,
      // ),
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: SafeArea(
          top: false,
          child: Column(
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
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.myCoursesList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                    itemBuilder: (context, index) {
                      final data = controller.myCoursesList[index];
                      return _myCoursesView(data);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _myCoursesView(CourseModel data){
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return  Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.singleCoursesView,arguments: data);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
              gradient: LinearGradient(colors: [
                Color(0xffFFFFFF),
                Color(0xffFFFFFF).withValues(alpha: 0.50),
              ],begin: Alignment.topCenter,
                  end:Alignment.bottomCenter )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      data.image,   // make sure data.image is the correct path from assets
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Row(
                      children: [
                        Obx(
                              () => InkWell(
                            onTap: () {
                              data.isFavourite.value =
                              !data.isFavourite.value;
                              showSuccessMessage(
                                context: context,
                                title: data.isFavourite.value
                                    ? CourseCartStrings.itemAddedSuccessfully
                                    : CourseCartStrings
                                    .itemRemoved,
                                content: '',
                              );
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: AppColors.black.withValues(
                                  alpha: 0.15,
                                ),
                                border: Border.all(
                                  color: AppColors.white.withValues(
                                    alpha: 0.75,
                                  ),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.white,
                                    AppColors.white.withValues(
                                      alpha: 0.50,
                                    ),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(blurRadius: 14),
                                ],
                              ),
                              child: Center(
                                child: data.isFavourite.value
                                    ? SvgImageFromAsset(
                                  AppCommonIcon.likeIcon,
                                )
                                    : SvgImageFromAsset(
                                  AppCommonIcon.wishlistIcon,
                                  colorFilter:
                                  ColorFilter.mode(
                                    AppColors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(10),
                        InkWell(
                          onTap: () {
                            SharePlus.instance.share(
                              ShareParams(text: data.name),
                            );
                          },
                          child: SvgImageFromAsset(
                            CommonImageAssets.shareImg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Gap(15),
              CommonText.semiBold(data.name, size: 15),
              Gap(10),
              CommonText.regular(
                data.description,
                size: 14,
                color:isDarkMode?AppColors.bodyTextDarkColor: AppColors.bodyTextColor,
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.medium(
                    MyCoursesStrings.courseStatus,
                    size: 14,
                  ),
                  CommonText.medium(
                    data.status == "Completed"
                        ? "Completed"
                        : "${data.noOfCompletedLectures}/${data.noOfLectures} Lectures • ${(data.progressValue * 100).toStringAsFixed(0)}%",
                    size: 14,
                    color: data.status == "Completed"
                        ? AppColors.success500
                        : isDarkMode
                            ? AppColors.white
                            : AppColors.headingsColor,
                  ),
                ],
              ),
              Gap(15),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(66),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: AppColors.black.withValues(
                        alpha: 0.08,
                      ),
                      blurRadius: 9,
                    ),
                  ],
                ),
                child: LinearProgressIndicator(
                  minHeight: 9,
                  color: AppColors.primary500,
                  backgroundColor: Colors.transparent,
                  value: data.progressValue,
                  borderRadius: BorderRadius.circular(66),

                  // trackGap: 20,
                  // stopIndicatorRadius: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
