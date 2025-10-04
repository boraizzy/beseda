import 'package:education_app/presentation/common_widgets/widgets/common_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_route.dart';
import '../../../../common_widgets/view_common_widget/common_course_view.dart';
import '../controller/trainer_profile_controller.dart';

class MyCoursesViewList extends StatefulWidget {
  const MyCoursesViewList({super.key});

  @override
  State<MyCoursesViewList> createState() => _MyCoursesViewListState();
}

class _MyCoursesViewListState extends State<MyCoursesViewList> {
  TrainerProfileController controller = Get.put(TrainerProfileController());

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;

    return Obx(
      () => ListView.separated(
        itemCount: controller.detail.value.myCoursesList.length,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: horizontalSpacing,vertical: 20),
        itemBuilder: (context, index) {
          final data = controller.detail.value.myCoursesList[index];
          return InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.courseDetailView, arguments: data);
            },
            child: RelatedCoursesView(data: data),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12,top: 12),
            child: CommonDivider(),
          );
        },
      ),
    );
  }
}
