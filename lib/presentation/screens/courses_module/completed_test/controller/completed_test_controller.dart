import 'package:get/get.dart';
import '../../../home_module/quiz_list/model/quiz_model.dart';

class CompletedTestController extends GetxController {
  int? correctAnswerCount;
  int? totalQuestionCount;
  RxList<QuizModel>? answerList;
  late final String title;
  QuizModel? data;
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('data') && arguments['data'] is QuizModel) {
        data = arguments['data'];
      }
      if (arguments.containsKey('list') &&
          arguments['list'] is RxList<QuizModel>) {
        answerList = arguments['list'];
      }
      if (arguments.containsKey('correctCount') &&
          arguments['correctCount'] is int) {
        correctAnswerCount = arguments['correctCount'];
      }
      if (arguments.containsKey('total') && arguments['total'] is int) {
        totalQuestionCount = arguments['total'];
      }
      if (arguments.containsKey('title') && arguments['title'] is String) {
        title = arguments['title'];
      }
    } else {}
  }
}
