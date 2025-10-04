import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class EditProfileController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  RxBool isLoading = false.obs;
  var selectedImagePath = ''.obs;
  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {



    }
  }

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (!isValid) return;

    isLoading.value = true;

    await Future.delayed(Duration(seconds: 1));

    formKey.currentState!.save();

    isLoading.value = false;

   Get.back();
  }
}