import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../app/app_route.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode currentPasswordFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> submit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (!isValid) {
      return false;
    }

    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar("Error", "Паролите не съвпадат");
      return false;
    }

    try {
      User? user = _auth.currentUser;

      if (user != null && user.email != null) {
        // ✅ Reauthenticate user with current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPasswordController.text.trim(),
        );

        await user.reauthenticateWithCredential(credential);

        // ✅ Update to new password
        await user.updatePassword(passwordController.text.trim());

        Get.toNamed(AppRouteName.changePasswordSuccessfullyView);
        return true;
      } else {
        Get.snackbar("Error", "Няма активен потребител");
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Грешка при смяна на паролата");
      return false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }
}
