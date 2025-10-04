import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/app_route.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (!isValid) return;

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(email: emailController.text.trim());

      Get.snackbar("Успешно", "Изпратихме линк за възстановяване на парола на ${emailController.text}");

      Get.offNamed(AppRouteName.resetPasswordSuccessfullyView);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Неуспешно изпращане на имейл за възстановяване");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
