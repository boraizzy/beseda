import 'dart:convert';

import 'course_model.dart';

class UniversityModel {
  int id = 0;
  String name = '';
  String image = '';
  String description = '';
  int noOfCourses = 0;
  double courseRate = 0.0;
  List<CourseModel> availableCourseList = [];
  UniversityModel.empty();
  UniversityModel({
    required this.id,
    required this.name,
    required this.image,
    required this.noOfCourses,
    required this.description,
    required this.courseRate,
    required this.availableCourseList,
  });
  factory UniversityModel.fromRawJson(String str) =>
      UniversityModel.fromJson(json.decode(str));
  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      noOfCourses: json['noOfCourses'] ?? 0,
      description: json['description'] ?? '',
      courseRate: json['courseRate'] ?? 0.0,
      availableCourseList:
      (json['available_courses_list'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
