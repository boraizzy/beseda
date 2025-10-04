import 'dart:convert';
import '../../home/model/course_model.dart';
import 'designation_model.dart';

class UserProfileModel {
  String profileUrl = '';
  String name = '';
  String email = '';
  List<DesignationModel> designationList = [];
  int courseEnrolled = 0;
  double averageScore = 0.0;
  int days = 0;
  int totalCoins = 0;
  List<CourseModel> completedList = [];
  List<CourseModel> onGoingList = [];
  UserProfileModel.empty();
  UserProfileModel({
    required this.profileUrl,
    required this.name,
    required this.email,
    required this.designationList,
    required this.courseEnrolled,
    required this.averageScore,
    required this.days,
    required this.totalCoins,
    required this.completedList,
    required this.onGoingList,
  });
  factory UserProfileModel.fromRawJson(String str) =>
      UserProfileModel.fromJson(json.decode(str));

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      profileUrl: json['profile_url'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      designationList:
          (json['designationList'] as List<dynamic>?)
              ?.map((e) => DesignationModel.fromJson(e))
              .toList() ??
          [],
      courseEnrolled: json['courseEnrolled'] ?? 0,
      averageScore: json['averageScore'] ?? 0.0,
      days: json['days'] ?? 0,
      totalCoins: json['totalCoins'] ?? 0,
      completedList:
          (json['completedCourseList'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
      onGoingList:
          (json['onGoingCoursesList'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
    );
  }
  UserProfileModel copyWith({
    String? profileUrl,
    String? name,
    String? email,
    List<DesignationModel>? designationList,
    int? courseEnrolled,
    double? averageScore,
    int? days,
    int? totalCoins,
    List<CourseModel>? completedList,
    List<CourseModel>? onGoingList,
  }) {
    return UserProfileModel(
      profileUrl: profileUrl ?? this.profileUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      designationList: designationList ?? this.designationList,
      courseEnrolled: courseEnrolled ?? this.courseEnrolled,
      averageScore: averageScore ?? this.averageScore,
      days: days ?? this.days,
      totalCoins: totalCoins ?? this.totalCoins,
      completedList: completedList ?? this.completedList,
      onGoingList: onGoingList ?? this.onGoingList,
    );
  }
}
