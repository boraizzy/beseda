import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_model.dart';
class AiLearningController extends GetxController{
  RxList<CourseModel> suggestedCoursesList = <CourseModel>[].obs;
  RxList<CourseModel> topRecommendedList = <CourseModel>[].obs;
  RxList<CourseModel> topRatedList = <CourseModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  void fetchData() {
    fetchFeaturedCourses();
    fetchTopRecommendedCourses();
    fetchTopRatedCourses();

  }

  void fetchFeaturedCourses() async {
    suggestedCoursesList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.featuredCourse,
        'featured_Course_List',
            (json) => CourseModel.fromJson(json),
      );

      suggestedCoursesList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error featured_Course_List : $e');
      }
    } finally {}
  }
  void fetchTopRecommendedCourses() async {
    topRecommendedList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.topRecommendedCourse,
        'top_Recommended_CourseList',
            (json) => CourseModel.fromJson(json),
      );

      topRecommendedList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error top_Recommended_CourseList : $e');
      }
    } finally {}
  }
  void fetchTopRatedCourses() async {
    topRatedList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.topRatedCourse,
        'top_Rated_CourseList',
            (json) => CourseModel.fromJson(json),
      );

      topRatedList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error top_Rated_CourseList : $e');
      }
    } finally {}
  }
}