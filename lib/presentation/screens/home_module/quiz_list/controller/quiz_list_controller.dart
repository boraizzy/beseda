import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/course_category.dart';
import '../model/quiz_model.dart';

class QuizListController extends GetxController {
  RxList<CourseCategory> allCourseCategoryList = <CourseCategory>[].obs;
  RxList<QuizModel> quizList = <QuizModel>[].obs;

  RxInt selectedIndex = 0.obs;
  RxInt selectedQuizIndex = (-1).obs;

  void selection(int index) {
    selectedIndex.value = index;
    update();
  }

  void quizSelection(int index) {
    selectedQuizIndex.value = index;
    update();
  }

  @override
  void onReady() {
    fetchAllCoursesCategory();
   fetchQuizById(100);
    super.onReady();
  }

  void fetchAllCoursesCategory() async {
    allCourseCategoryList.clear();
    try {
      final data = await loadListFromAsset<CourseCategory>(
        AppJsonPath.allCourseCategory,
        'all_course_category',
        (json) => CourseCategory.fromJson(json),
      );
      allCourseCategoryList.add(
        CourseCategory(
          id: 100,
          name: 'All',
          image: '',
          courseColor: '',
          courseBgColor: '',
          quizList: [],
        ),
      );

      allCourseCategoryList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error all_course_category : $e');
      }
    } finally {}
  }

  Future<void> fetchQuizById(int? categoryId) async {
    quizList.clear();
    try {
      final data = await loadListFromAsset<QuizModel>(
        AppJsonPath.quizList,
        'quiz_list',
        (json) => QuizModel.fromJson(json),
      );

      if (categoryId == 100) {
        // 🔥 "ALL" → add every quiz
        quizList.addAll(data);
      } else {
        // 🔑 category -> quiz ids mapping
        final Map<int, List<int>> categoryQuizMap = {
          1: [1],       // Category 1 has quizzes 1,2,3
          2: [3],       // Category 2 has quizzes 4,5,6
          3: [2],          // Category 3 has quizzes 7,8
          4: [4],     // Category 4 has quizzes 9,10,11
          5: [5] // Category 5 has quizzes 12,13,14,15
        };

        final allowedIds = categoryQuizMap[categoryId] ?? [];
        quizList.addAll(
          data.where((quiz) => allowedIds.contains(quiz.id)),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error quiz_list: $e');
      }
    }
  }

}
