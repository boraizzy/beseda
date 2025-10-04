import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../../../app/app_route.dart';
import '../../quiz_list/model/quiz_model.dart';
import '../model/course_category.dart';
import '../model/course_model.dart';
import '../model/university_model.dart';

class HomeController extends GetxController {
  var searchController = TextEditingController();
  RxList<CourseModel> ongoingCoursesList = <CourseModel>[].obs;
  RxList<CourseCategory> courseCategoryList = <CourseCategory>[].obs;
  RxList<CourseModel> featuredCoursesList = <CourseModel>[].obs;
  RxList<UniversityModel> universityList = <UniversityModel>[].obs;
  RxList<CourseModel> topRecommendedList = <CourseModel>[].obs;
  RxList<CourseModel> topRatedList = <CourseModel>[].obs;
  RxList<QuizModel> mockTestList = <QuizModel>[].obs;

  final FocusNode searchFocusNode = FocusNode();

  String get _uid => FirebaseAuth.instance.currentUser!.uid;
  DocumentReference<Map<String, dynamic>> get _userDoc =>
      FirebaseFirestore.instance.collection('users').doc(_uid);

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void fetchHomeData() {
    fetchOngoingCourses();
    fetchCourseCategory();
    fetchFeaturedCourses();
    fetchUniversity();
    fetchTopRecommendedCourses();
    fetchTopRatedCourses();
    fetchMockTest();
  }

  void fetchOngoingCourses() async {
    ongoingCoursesList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.ongoingCourses,
        'on_Going_Courses',
        (json) => CourseModel.fromJson(json),
      );
      ongoingCoursesList.addAll(data);
    } catch (e) {
      if (kDebugMode) print('Error on_Going_Courses : $e');
    }
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
      if (kDebugMode) print('Error course_Category_List : $e');
    }
  }

  void fetchFeaturedCourses() async {
    featuredCoursesList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.featuredCourse,
        'featured_Course_List',
        (json) => CourseModel.fromJson(json),
      );
      featuredCoursesList.addAll(data);
    } catch (e) {
      if (kDebugMode) print('Error featured_Course_List : $e');
    }
  }

  void fetchUniversity() async {
    universityList.clear();
    try {
      final data = await loadListFromAsset<UniversityModel>(
        AppJsonPath.universityList,
        'university_List',
        (json) => UniversityModel.fromJson(json),
      );
      universityList.addAll(data);
    } catch (e) {
      if (kDebugMode) print('Error university_List : $e');
    }
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
      if (kDebugMode) print('Error top_Recommended_CourseList : $e');
    }
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
      if (kDebugMode) print('Error top_Rated_CourseList : $e');
    }
  }

  /// Load quizzes from local JSON, then overlay with Firestore statuses
  void fetchMockTest() async {
    mockTestList.clear();
    try {
      final raw = await rootBundle.loadString(AppJsonPath.mockTest);
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final data = (map['mock_Test_List'] as List<dynamic>? ?? [])
          .map((json) => QuizModel.fromJson(json))
          .toList();

      mockTestList.addAll(data);

      // 🔥 Overlay Firestore statuses
      final snap = await _userDoc.get();
      final mockTests = snap.data()?['mockTests'] as Map<String, dynamic>? ?? {};

      for (var i = 0; i < mockTestList.length; i++) {
        final q = mockTestList[i];
        if (mockTests.containsKey(q.id.toString())) {
          q.status = mockTests[q.id.toString()];
        }
      }

      mockTestList.refresh();
    } catch (e) {
      if (kDebugMode) print('Error mock_Test_List : $e');
    }
  }

  /// Mark quiz as completed (updates local + Firestore)
  Future<void> markQuizCompleted(QuizModel quiz) async {
    // 1. Update locally
    final idx = mockTestList.indexWhere((x) => x.id == quiz.id);
    if (idx != -1) {
      mockTestList[idx].status = 'Completed';
      mockTestList.refresh();
    }

    // 2. Persist to Firestore (merge into mockTests map)
    await _userDoc.set({
      "mockTests": {quiz.id.toString(): "Completed"}
    }, SetOptions(merge: true));
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void navigateToSearchScreen() {
    Get.toNamed(AppRouteName.searchScreenView)?.then((_) {
      searchFocusNode.unfocus();
    });
  }
}
