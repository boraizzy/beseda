import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../../../app/app_route.dart';
import '../../quiz_list/model/quiz_model.dart';

class QuizController extends GetxController {
  String? type;
  //TestModel? test;
  QuizModel? data;
   RxList<QuizModel>? answerList;
  RxList<QuizModel> quizList = <QuizModel>[].obs;
  final PageController pageController = PageController();
  RxInt pageIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    handleArguments();
    fetchQuizDetail();
    pageController.addListener(() {
      pageIndex.value = pageController.page?.round() ?? 0;
    });



  }
  void handleArguments() {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      type = arguments['type'] as String?;
      data = arguments['data'] as QuizModel?;
      answerList = arguments['list'] as RxList<QuizModel>?;

    }
  }

  void fetchQuizDetail() async {
    quizList.clear();
    try {
      final data = await loadListFromAsset<QuizModel>(
        AppJsonPath.quizAnswerQuestionsList,
        'quiz_list',
        (json) => QuizModel.fromJson(json),
      );

      quizList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error all_course_category : $e');
      }
    } finally {}
  }
  void onPageChanged(int index) {
    pageIndex.value = index;
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
  void selectOption(int questionIndex, int optionIndex) {
    quizList[questionIndex].selectedOptionIndex = optionIndex;
    quizList.refresh();
  }

  int get correctAnswerCount =>getCorrectAnswerCount(quizList);
  int get totalQuestionCount => quizList.length;

  void goToNextPage() {
    final isLastPage = pageIndex.value == quizList.length - 1;

    if (isLastPage) {
      final args = {
        'data': data,
        'list': quizList,
        'correctCount': correctAnswerCount,
        'total': totalQuestionCount,
      };

      if (type != null && type!.isNotEmpty) {
        args['title'] = data!.name;
        Get.offNamedUntil(
          AppRouteName.completedTestView,
              (route) => route.isFirst,
          arguments: args,
        );
      } else {
        Get.offNamedUntil(
          AppRouteName.quizSubmittedView,
              (route) => route.isFirst,
          arguments: args,
        );
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }


  int getCorrectAnswerCount(List<QuizModel> list) {
    return list.where((quiz) => quiz.selectedOptionIndex == quiz.correctOptionIndex).length;
  }

}
