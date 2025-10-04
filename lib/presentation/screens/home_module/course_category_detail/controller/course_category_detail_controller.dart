import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_model.dart';
import '../../home/model/course_category.dart';

class CourseCategoryDetailController extends GetxController {
  late CourseCategory category;

  // 🔹 Add this line
  Rx<CourseModel> courseData = CourseModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments as CourseCategory;
    fetchCourseData();
  }

  void fetchCourseData() async {
    try {
      courseData.value = await loadJsonFromAsset<CourseModel>(
        AppJsonPath.courseCategoryDetail,
        (json) => CourseModel.fromRawJson(jsonEncode(json)),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading : $e');
      }
    }
  }
}
