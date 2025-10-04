import 'dart:convert';
import 'package:get/get.dart';
import '../../course_category_detail/model/instructor_model.dart';
import '../../course_detail/model/course_curriculum_model.dart';
import '../../course_detail/model/course_feature_list_model.dart';
import '../../course_detail/model/course_out_comes_model.dart';
import '../../course_detail/model/user_model.dart';

class CourseModel {
  int id = 0;
  String name = '';
  String image = '';
  int coursesNo = 0;
  int percentage = 0;
  double progressValue = 0.0;
  double courseFees = 0.0;
  double rate = 0.0;
  String instructorName = '';
  int noOfLectures = 0;
  int noOfCompletedLectures = 0;
  String progressColor = '';
  RxBool isFavourite = false.obs;
  String videoUrl = '';
  String date = '';
  String description = '';
  // int session = 0;
  String level = '';
  String status = '';
  int sessions = 0;
  // int lectures = 0;
  List<CourseOutComesModel> courseOutComesList = [];
  List<CourseCurriculumModel> courseCurriculumList = [];
  List<CourseFeatureListModel> courseFeatureList = [];
  String instructorProfileImg = '';
  String qualification = '';
  int noOfStudents = 0;
  List<CourseModel> courseList = [];
  List<String> requirements = [];
  double courseRating = 0.0;
  List<UserModel> reviewList = [];
  List<InstructorModel> instructorList = [];
  List<CourseModel> relatedCourseList = [];
  bool isLiveClasses = false;
  int storage = 0;
  Set<int> completedLectures = {};

  CourseModel.empty();
  CourseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.coursesNo,
    required this.percentage,
    required this.progressValue,
    required this.courseFees,
    required this.rate,
    required this.instructorName,
    required this.noOfLectures,
    required this.noOfCompletedLectures,
    required this.progressColor,
    required this.videoUrl,
    required this.date,
    required this.description,
    // required this.session,
    required this.level,
    required this.status,
    required this.sessions,
   // required this.lectures,
    required this.courseOutComesList,
    required this.courseCurriculumList,
    required this.courseFeatureList,
    required this.instructorProfileImg,
    required this.qualification,
    required this.noOfStudents,
    required this.courseList,
    required this.requirements,
    required this.courseRating,
    required this.reviewList,
    required this.instructorList,
    required this.relatedCourseList,
    required this.isLiveClasses,
    required this.storage,
  });
  factory CourseModel.fromRawJson(String str) =>
      CourseModel.fromJson(json.decode(str));

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      coursesNo: json['coursesNo'] ?? 0,
      percentage: json['percentage'] ?? 0,
      progressValue: (((json['completedLectures'] as List<dynamic>?) ?? []).length) /
          ((((json['course_curriculum_list'] as List<dynamic>?) ?? [])
                  .fold<int>(0, (sum, section) {
                    final lectures =
                        (section['lecturesList'] as List<dynamic>?) ?? [];
                    return sum + lectures.length;
                  })) == 0
              ? 1
              : ((json['course_curriculum_list'] as List<dynamic>?) ?? [])
                  .fold<int>(0, (sum, section) {
                    final lectures =
                        (section['lecturesList'] as List<dynamic>?) ?? [];
                    return sum + lectures.length;
                  })),
      courseFees: (json['courseFees'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
      instructorName: json['instructorName'] ?? '',
      noOfLectures: ((json['course_curriculum_list'] as List<dynamic>?) ?? [])
          .fold<int>(0, (sum, section) {
            final lectures = (section['lecturesList'] as List<dynamic>?) ?? [];
            return sum + lectures.length;
          }),

      noOfCompletedLectures: ((json['completedLectures'] as List<dynamic>?) ?? [])
          .map((e) => e as int)
          .toSet()
          .length,

      progressColor: json['progressColor'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      // session: json['session'] ?? 0,
      level: json['level'] ?? '',
      status: (((json['completedLectures'] as List<dynamic>?) ?? []).length >=
              (((json['course_curriculum_list'] as List<dynamic>?) ?? [])
                  .fold<int>(0, (sum, section) {
                    final lectures = (section['lecturesList'] as List<dynamic>?) ?? [];
                    return sum + lectures.length;
                  })))
          ? "Completed"
          : "In Progress",
      sessions: json['sessions'] ?? 0,
      //lectures: json['lectures'] ?? 0,
      courseOutComesList:
          (json['CourseOutComesList'] as List<dynamic>?)
              ?.map((e) => CourseOutComesModel.fromJson(e))
              .toList() ??
          [],
      courseCurriculumList:
          (json['course_curriculum_list'] as List<dynamic>?)
              ?.map((e) => CourseCurriculumModel.fromJson(e))
              .toList() ??
          [],
      courseFeatureList:
          (json['course_features_list'] as List<dynamic>?)
              ?.map((e) => CourseFeatureListModel.fromJson(e))
              .toList() ??
          [],
      instructorProfileImg: json['instructorProfileImg'] ?? '',
      qualification: json['qualification'] ?? '',
      noOfStudents: json['noOfStudents'] ?? 0,
      courseList:
          (json['course_list'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
      requirements:
          (json['requirements'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      courseRating: (json['course_rating'] ?? 0).toDouble(),
      reviewList:
          (json['review_list'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
      instructorList:
          (json['instructor_list'] as List<dynamic>?)
              ?.map((e) => InstructorModel.fromJson(e))
              .toList() ??
          [],
      relatedCourseList:
          (json['related_course_list'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          [],
      isLiveClasses: json['isLiveClasses'] ?? false,
      storage: json['storage'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "coursesNo": coursesNo,
      "percentage": percentage,
      "progressValue": progressValue,
      "courseFees": courseFees,
      "rate": rate,
      "instructorName": instructorName,
      "noOfLectures": courseCurriculumList.fold<int>(
        0,
        (sum, section) => sum + section.lecturesList.length,
      ),
      "noOfCompletedLectures": completedLectures.length,
      "progressColor": progressColor,
      "videoUrl": videoUrl,
      "date": date,
      "description": description,
      "level": level,
      "status": status,
      "sessions": sessions,
      "courseOutComesList": courseOutComesList.map((e) => e.toJson()).toList(),
      "course_curriculum_list": courseCurriculumList.map((e) => e.toJson()).toList(),
      "course_features_list": courseFeatureList.map((e) => e.toJson()).toList(),
      "instructorProfileImg": instructorProfileImg,
      "qualification": qualification,
      "noOfStudents": noOfStudents,
      "courseList": courseList.map((e) => e.toJson()).toList(),
      "requirements": requirements,
      "courseRating": courseRating,
      "reviewList": reviewList.map((e) => e.toJson()).toList(),
      "instructorList": instructorList.map((e) => e.toJson()).toList(),
      "relatedCourseList": relatedCourseList.map((e) => e.toJson()).toList(),
      "isLiveClasses": isLiveClasses,
      "storage": storage,
      "completedLectures": completedLectures.toList(),
    };
  }

}
