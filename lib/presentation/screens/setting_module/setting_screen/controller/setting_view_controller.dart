import 'package:get/get.dart';
import '../../../../app/theme_controller.dart';
class SettingViewController extends GetxController{
  RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
    isDarkMode.value =   Get.find<ThemeController>().isDarkMode;
  }
}