part of 'course_listing_imports.dart';

class CourseListingView extends StatefulWidget {
  const CourseListingView({super.key});

  @override
  State<CourseListingView> createState() => _CourseListingViewState();
}

class _CourseListingViewState extends State<CourseListingView> {
  CourseListingController controller = Get.put(CourseListingController());
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
                child: Obx(
                  () => ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                      vertical: horizontalSpacing
                    ),
                    itemBuilder: (context, index) {
                      final data = controller.coursesList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRouteName.courseDetailView,
                              arguments: data,
                            );
                          },
                          child: RelatedCoursesView(data: data),
                        ),
                      );
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
}
