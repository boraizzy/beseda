import 'dart:convert';
import 'package:education_app/presentation/screens/setting_module/my_progress/model/rank_model.dart';

import '../../../home_module/home/model/course_model.dart';
import 'achievement_model.dart';

class MyProgressModel {
  List<RankModel> rankList = [];
  List<CourseModel> courseList = [];
  List<CourseModel> onGoingCoursesList = [];
  List<AchievementModel> achievementList = [];
  int totalPoints = 0;
  int balancedPoints = 0;
  int usedPoints = 0;

  MyProgressModel.empty();
  MyProgressModel({
    required this.rankList,
    required this.courseList,
    required this.onGoingCoursesList,
    required this.achievementList,
    required this.totalPoints,
    required this.balancedPoints,
    required this.usedPoints,
  });
  factory MyProgressModel.fromRawJson(String str) =>
      MyProgressModel.fromJson(json.decode(str));
  factory MyProgressModel.fromJson(Map<String, dynamic> json) {
    return MyProgressModel(
      rankList:
          (json['rank_list'] as List<dynamic>?)
              ?.map((e) => RankModel.fromJson(e))
              .toList() ??
          [],
      courseList:
          (json['courses_list'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
      onGoingCoursesList:
          (json['ongoing_courses_list'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
      achievementList:
          (json['achievement_list'] as List<dynamic>?)
              ?.map((e) => AchievementModel.fromJson(e))
              .toList() ??
          [],
      totalPoints: json['total_points'] ?? 0.0,
      balancedPoints: json['balance_points'] ?? 0.0,
      usedPoints: json['used_points'] ?? 0.0,
    );
  }
}
