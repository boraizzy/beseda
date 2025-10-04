import 'package:get/get.dart';

class FaqModel {
  final String question;
  final String answer;
  final RxBool isExpanded;

  FaqModel({
    required this.question,
    required this.answer,
    bool isExpanded = false,
  }) : isExpanded = isExpanded.obs;
}