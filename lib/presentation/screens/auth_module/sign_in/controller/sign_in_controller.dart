import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../utils/extensions/shared_preference.dart';
import '../../../../app/app_route.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  RxBool isLoading = false.obs;
  RxBool isRememberMe = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (!isValid) return;

    try {
      isLoading.value = true;

      // ✅ Try to log in with Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = result.user;

      if (user != null) {
        // ✅ Save login state in SharedPreferences
        AppSharedPreference.setUserLoggedIn(true);

        // ✅ Navigate to home/bottom view
        Get.offNamedUntil(AppRouteName.bottomView, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Грешка при вход");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
