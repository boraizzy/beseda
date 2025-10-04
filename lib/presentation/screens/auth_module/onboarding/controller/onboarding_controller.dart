import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_strings.dart';
import '../model/onboarding_model.dart';
class OnboardingController extends GetxController{
  RxInt pageIndex = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      pageIndex.value = pageController.page?.round() ?? 0;
    });
  }

  void onPageChanged(int index) {
    pageIndex.value = index;
  }
  final onboardingData = [
    OnboardingModel(
      image: OnboardingAssets.onboardingOne,
      title: OnboardingStrings.onboardingTitleOne,
      subtitle: OnboardingStrings.onboardingSubtitleOne,

    ),
    OnboardingModel(
      image: OnboardingAssets.onboardingTwo,
      title: OnboardingStrings.onboardingTitleTwo,
      subtitle: OnboardingStrings.onboardingSubtitleTwo,

    ),
    OnboardingModel(
      image: OnboardingAssets.onboardingThree,
      title: OnboardingStrings.onboardingTitleThree,
      subtitle: OnboardingStrings.onboardingSubtitleThree,

    ),
  ];


}