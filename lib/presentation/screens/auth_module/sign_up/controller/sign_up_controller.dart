import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../utils/helpers/firebase_helper.dart';
import '../../../../app/app_route.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNoFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  RxBool isLoading = false.obs;
  RxBool isRememberMe = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (!isValid) return;

    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar("Error", "Паролите не съвпадат");
      return;
    }

    try {
      isLoading.value = true;

      // ✅ Register user with Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = result.user;

      if (user != null) {
        // ✅ Save extra user info in Firestore
        await _db.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneNoController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        // ✅ Initialize mockTests automatically
        await initializeMockTestsForUser(user.uid);

        // ✅ Send verification email
        await user.sendEmailVerification();

        // ✅ Navigate to verification screen
        Get.toNamed(AppRouteName.verificationView, arguments: {
          'email': emailController.text.trim(),
          'title': 'Sign Up',
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Error", e.message ?? "Неуспешна регистрация");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
