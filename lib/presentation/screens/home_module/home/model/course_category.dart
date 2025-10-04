import '../../quiz_list/model/quiz_model.dart';

class CourseCategory {
  int id = 0;
  String name = '';
  String image = '';
  String courseColor = '';
  String courseBgColor = '';
  List<QuizModel> quizList = [];
  CourseCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.courseColor,
    required this.courseBgColor,
    required this.quizList,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      courseColor: json['courseColor'] ?? '',
      courseBgColor: json['courseBgColor'] ?? '',
      quizList: (json['quiz_list'] as List<dynamic>?)
          ?.map((e) => QuizModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
