import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_model.dart';
class CourseCartController extends GetxController{
  RxList<CourseModel> courseCartList = <CourseModel>[].obs;
  TextEditingController nameController=TextEditingController();
  FocusNode nameFocus = FocusNode();
  RxList<CourseModel> topRecommendedList = <CourseModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
void fetchData(){
  fetchCartCourses();
  fetchTopRecommendedCourses();
}
  void fetchCartCourses() async {
    courseCartList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.cartList,
        'cartList',
            (json) => CourseModel.fromJson(json),
      );

      courseCartList.addAll(data);
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
}