import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ContactUsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNoFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (!isValid) return;

    try {
      await FirebaseFirestore.instance.collection("contact_messages").add({
        "first_name": fNameController.text,
        "last_name": lNameController.text,
        "email": emailController.text,
        "phone": phoneNoController.text,
        "message": messageController.text,
        "timestamp": FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Message sent successfully!",
          snackPosition: SnackPosition.BOTTOM);

      clearFields();
    } catch (e) {
      Get.snackbar("Error", "Failed to send message: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearFields() {
    fNameController.clear();
    lNameController.clear();
    emailController.clear();
    phoneNoController.clear();
    messageController.clear();
  }
}
