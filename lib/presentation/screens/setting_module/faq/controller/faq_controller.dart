import 'package:get/get.dart';
import '../../../../../core/constants/app_strings.dart';
import '../model/faq_model.dart';
class FaqController extends GetxController{
  final List<FaqModel> frequentQuestionsList = [
    FaqModel(
      question:"Какви курсове предлага приложението ? ",
      answer: FaqViewString.faqAns,
    ),
    FaqModel(
      question: 'Необходими ли са предварителни знания, за да започна ? ',
      answer: FaqViewString.faqAns1,
    ),
    FaqModel(
      question: 'Как протича обучението в приложението ? ',
      answer: FaqViewString.faqAns2,
    ),
    FaqModel(
      question: 'Мога ли да уча в собствено темпо ? ',
      answer: FaqViewString.faqAns3,
    ),
    FaqModel(
      question: 'Издава ли се сертификат след завършване на курс ? ',
      answer: FaqViewString.faqAns4,
    ),
  ];
  void toggleExpansion(FaqModel faq) {
    faq.isExpanded.value = !faq.isExpanded.value;

  }
}