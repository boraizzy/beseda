import 'package:get/get.dart';
class LearningGoalsController extends GetxController{
  var selectedIndex=0.obs;

  void selection(int index){
    selectedIndex.value=index;
  }


}