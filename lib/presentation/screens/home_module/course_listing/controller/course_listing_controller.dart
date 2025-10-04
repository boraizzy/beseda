import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_model.dart';

class CourseListingController extends GetxController{
  RxList<CourseModel> coursesList = <CourseModel>[].obs;
  late String title;
  @override
  void onInit() {
    super.onInit();
    fetchCourses();
     title=Get.arguments as String;
  }

  void fetchCourses() async {
    coursesList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.courseListing,
        'course_listing',
            (json) => CourseModel.fromJson(json),
      );

      coursesList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error course_listing : $e');
      }
    } finally {}
  }
}