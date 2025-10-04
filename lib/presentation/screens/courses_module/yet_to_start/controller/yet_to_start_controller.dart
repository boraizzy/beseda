import 'package:get/get.dart';
import '../../../../app/app_route.dart';

class YetToStartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  void goToNextScreen() {
    Future.delayed(
      Duration(seconds: 3),
      () => Get.toNamed(AppRouteName.startMeetingView),
    );
  }
}
