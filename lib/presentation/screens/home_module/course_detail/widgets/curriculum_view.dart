  import 'package:flutter/material.dart';
  import 'package:gap/gap.dart';
  import 'package:get/get.dart';
  import '../../../../../core/constants/app_colors.dart';
  import '../../../../app/theme_controller.dart';
  import '../../../../common_widgets/widgets/text.dart';
  import '../controller/course_detail_controller.dart';
  import 'common_view.dart';
  import '../../../../app/app_route.dart'; // <-- добави това ако го нямаш
  import 'package:education_app/presentation/screens/home_module/course_how_ai_works/mindmap.dart';
  import '../../../courses_module/my_courses/controller/my_courses_controller.dart';
  class CurriculumView extends StatefulWidget {
    const CurriculumView({super.key});

    @override
    State<CurriculumView> createState() => _CurriculumViewState();
  }

  class _CurriculumViewState extends State<CurriculumView> {
    CourseDetailController controller = Get.put(CourseDetailController());

    @override
    Widget build(BuildContext context) {
      const double horizontalSpacing = 20;
      bool isDarkMode = Get.find<ThemeController>().isDarkMode;
      return SingleChildScrollView(
        child: Obx(
              () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonText.medium(
                      '${controller.detail.value.sessions.toString()} Сесии',
                      size: 16,
                      color: isDarkMode
                          ? AppColors.bodyTextDarkColor
                          : AppColors.bodyTextColor,
                    ),
                    const Gap(10),
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: isDarkMode
                          ? AppColors.greyTextDarkColor
                          : AppColors.greyTextColor,
                    ),
                    const Gap(10),
                    CommonText.medium(
                      '${controller.detail.value.noOfLectures.toString()} Лекции',
                      size: 16,
                      color: isDarkMode
                          ? AppColors.bodyTextDarkColor
                          : AppColors.bodyTextColor,
                    ),
                  ],
                ),
              ),
              const Gap(12),
              ListView.builder(
                itemCount: controller.detail.value.courseCurriculumList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                itemBuilder: (context, index) {
                  final data = controller.detail.value.courseCurriculumList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.cardDarkBgColor
                              : AppColors.cardBgColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ExpansionTile(
                          collapsedIconColor: isDarkMode
                              ? AppColors.bodyTextDarkColor
                              : AppColors.bodyTextColor,
                          iconColor: isDarkMode
                              ? AppColors.bodyTextDarkColor
                              : AppColors.bodyTextColor,
                          title: Row(
                            children: [
                              Expanded(
                                child: CommonText.medium(
                                  data.title,
                                  size: 16,
                                  color: isDarkMode
                                      ? AppColors.headingsLightColor
                                      : AppColors.primary500,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              CommonText.regular(
                                '(0${data.lecturesList.length} Лекции)',
                                size: 14,
                                color: isDarkMode
                                    ? AppColors.bodyTextDarkColor
                                    : AppColors.bodyTextColor,
                              ),
                            ],
                          ),
                          children: [
                            Container(
                              color: isDarkMode
                                  ? AppColors.mainDarkBgColor
                                  : AppColors.white,
                              child: ListView.builder(
                                itemCount: data.lecturesList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, lectureIndex) {
                                  final lecture =
                                  data.lecturesList[lectureIndex];
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        CommonText.medium(
                                          '0${lecture.id.toString()}',
                                          size: 16,
                                          color: isDarkMode
                                              ? AppColors.bodyTextDarkColor
                                              : AppColors.bodyTextColor,
                                        ),
                                        const Gap(12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CommonText.medium(
                                                      lecture.name,
                                                      size: 14,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // 1. Update progress in MyCourses
                                                      final myCoursesController = Get.find<MyCoursesController>();
                                                      myCoursesController.addCourse(controller.course); // ensure it's in My Courses
                                                      myCoursesController.markLectureAsCompleted(controller.course.id, lecture.id);

                                                      // 2. Navigate based on lecture
                                                      if (index == 0 && lectureIndex == 0) {
                                                        // First lecture, open LevelOne
                                                        Get.toNamed(AppRouteName.levelOneScreen, arguments: lecture);
                                                      } else {
                                                        // Other lectures can go to a generic screen
                                                        Get.toNamed(AppRouteName.singleCoursesView, arguments: lecture);
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors.primary500,
                                                      foregroundColor: Colors.white,
                                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      textStyle: const TextStyle(fontSize: 12),
                                                    ),
                                                    child: const Text("Старт"),
                                                  ),
                                                ],
                                              ),
                                            CommonText.regular(
                                              lecture.timeOfVideo,
                                              size: 13,
                                              color: isDarkMode
                                                  ? AppColors.greyTextDarkColor
                                                  : AppColors.greyTextColor,
                                            ),

                                            if (index == 0 && lectureIndex == 0)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(() => const MindMapScreen());
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.primary500,
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Мисловна Карта",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              courseBottomView(),
            ],
          ),
        ),
      );
    }
  }
