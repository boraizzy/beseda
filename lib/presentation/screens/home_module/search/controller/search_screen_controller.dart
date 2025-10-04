import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_category.dart';
import '../../home/model/course_model.dart';
class SearchScreenController extends GetxController{
  var searchController = TextEditingController();
  RxList<CourseCategory> courseCategoryList = <CourseCategory>[].obs;
  RxList<CourseModel> smartCoursesList = <CourseModel>[].obs;
  RxList<CourseCategory> allCourseCategoryList = <CourseCategory>[].obs;

@override
  void onInit() {
    super.onInit();
    fetchDetail();
  }
  void fetchDetail(){
    fetchCourseCategory();
    fetchSmartCourses();
    fetchAllCoursesCategory();
  }
  void fetchCourseCategory() async {
    courseCategoryList.clear();
    try {
      final data = await loadListFromAsset<CourseCategory>(
        AppJsonPath.courseCategory,
        'course_Category_List',
            (json) => CourseCategory.fromJson(json),
      );

      courseCategoryList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error course_Category_List : $e');
      }
    } finally {}
  }
  void fetchSmartCourses() async {
    smartCoursesList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.topRecommendedCourse,
        'top_Recommended_CourseList',
            (json) => CourseModel.fromJson(json),
      );

      smartCoursesList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error top_Recommended_CourseList : $e');
      }
    } finally {}
  }

  void fetchAllCoursesCategory() async {
    allCourseCategoryList.clear();
    try {
      final data = await loadListFromAsset<CourseCategory>(
        AppJsonPath.allCourseCategory,
        'all_course_category',
            (json) => CourseCategory.fromJson(json),
      );

      allCourseCategoryList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error all_course_category : $e');
      }
    } finally {}
  }
}