import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_route.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  RxBool isLoading = false.obs;
  // bool submit() {
  //   final isValid = formKey.currentState!.validate();
  //   Get.focusScope!.unfocus();
  //   if (!isValid) {
  //     return false;
  //   }
  //   Get.toNamed(AppRouteName.verificationView,arguments: {
  //     'email':emailController.text,
  //     'title':'Forgot Password'
  //   });
  //   formKey.currentState!.save();
  //   return true;
  // }

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (!isValid) return;

    isLoading.value = true;

    await Future.delayed(Duration(seconds: 1));

    formKey.currentState!.save();

    isLoading.value = false;

    Get.toNamed(AppRouteName.verificationView,arguments: {
      'email':emailController.text,
      'title':'Забравена парола'
    });
  }
}
