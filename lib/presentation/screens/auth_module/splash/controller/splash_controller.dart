import 'package:education_app/presentation/app/app_route.dart';
import 'package:get/get.dart';

import '../../../../../utils/extensions/shared_preference.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  // void goToNextScreen() {
  //   Future.delayed(
  //     Duration(seconds: 3),
  //     () => Get.offNamed(AppRouteName.onboardingView),
  //   );
  // }

  void goToNextScreen() async {
    bool isFirstTimeOnboarding = await AppSharedPreference.getIsFirstTimeOnboarding();
    bool isLogin = await AppSharedPreference.getUserLoggedIn();

    await Future.delayed(Duration(
      seconds: 3,
    ));
    if (isFirstTimeOnboarding) {
      Get.offNamed(AppRouteName.onboardingView);
    }
    else if (isLogin) {
      Get.offNamed(AppRouteName.bottomView);
    } else {
      Get.offNamed(AppRouteName.signInView);
    }
  }
}
