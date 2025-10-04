import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/model/course_category.dart';
class CourseCategoryController extends GetxController{
  RxList<CourseCategory> filteredICourseCategoryList = <CourseCategory>[].obs;
  var searchQuery = ''.obs;
  final searchController = TextEditingController().obs;
 late RxList<CourseCategory> allCourseCategoryList;
  @override
  void onInit() {
    super.onInit();
    allCourseCategoryList=Get.arguments as RxList<CourseCategory>;
    filteredICourseCategoryList.value=allCourseCategoryList;
  }
  void search(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredICourseCategoryList.value = allCourseCategoryList;
    } else {
      filteredICourseCategoryList.value = allCourseCategoryList
          .where((item) =>
          item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}