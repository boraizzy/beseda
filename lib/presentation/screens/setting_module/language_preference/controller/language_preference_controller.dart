import 'package:get/get.dart';

class LanguagePreferenceController extends GetxController{
 var selectedLanguage=0.obs;

  void languageSelection(int index){
    selectedLanguage.value=index;
  }
  List<String>languageList=[
    'English',
    'German',
    'Spanish',
    'French'
  ];

}