import 'dart:convert';
import '../../home/model/course_model.dart';

class InstructorModel {
  int id = 0;
  String name = '';
  String image = '';
  String qualification = '';
  int noOfStudents = 0;
  int noOfCourses = 0;
  int noOfReviews = 0;
  String description = '';
  List<String> descriptionList = [];
  List<CourseModel> myCoursesList = [];
  InstructorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.qualification,
    required this.noOfStudents,
    required this.noOfCourses,
    required this.noOfReviews,
    required this.description,
    required this.descriptionList,
    required this.myCoursesList,
  });
  InstructorModel.empty();
  factory InstructorModel.fromRawJson(String str) =>
      InstructorModel.fromJson(json.decode(str));
  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      qualification: json['qualification'] ?? '',
      noOfStudents: json['noOfStudents'] ?? 0,
      noOfCourses: json['noOfCourses'] ?? 0,
      noOfReviews: json['noOfReviews'] ?? 0,
      description: json['description'] ?? '',
      descriptionList:
          (json['descriptionList'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      myCoursesList:
          (json['my_courses_list'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "qualification": qualification,
      "noOfStudents": noOfStudents,
      "noOfCourses": noOfCourses,
      "noOfReviews": noOfReviews,
      "description": description,
      "descriptionList": descriptionList,
      "my_courses_list": myCoursesList.map((e) => e.toJson()).toList(),
    };
  }
}
