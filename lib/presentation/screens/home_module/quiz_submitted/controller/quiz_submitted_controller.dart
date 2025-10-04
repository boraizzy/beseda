import 'package:get/get.dart';
import '../../quiz_list/model/quiz_model.dart';
class QuizSubmittedController extends GetxController{
   QuizModel? data;
   RxList<QuizModel>? answerList;

   @override
   void onInit() {
     super.onInit();

     final arguments = Get.arguments;
     if (arguments != null && arguments is Map<String, dynamic>) {
       if (arguments.containsKey('data') && arguments['data'] is QuizModel) {
         data = arguments['data'];
       }
       if (arguments.containsKey('list') && arguments['list'] is RxList<QuizModel>) {
         answerList = arguments['list'];
       }
     }
     else {
     }
   }
}