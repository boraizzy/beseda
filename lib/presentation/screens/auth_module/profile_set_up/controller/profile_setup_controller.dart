import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:education_app/presentation/app/app_route.dart';

class ProfileSetupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Example fields (you can collect these from Profile Setup View)
  var bio = "".obs;
  var avatarUrl = "".obs;
  var age = "".obs;

  @override
  void onInit() {
    super.onInit();
    // You can decide: save profile automatically, or only when user taps a button
    // For now we just wait and then navigate
    goToNextScreen();
  }

  Future<void> saveProfile({
    String? bio,
    String? avatarUrl,
    String? age,
  }) async {
    try {
      final uid = _auth.currentUser!.uid;
      await _db.collection("users").doc(uid).update({
        if (bio != null) "bio": bio,
        if (avatarUrl != null) "avatarUrl": avatarUrl,
        if (age != null) "age": age,
        "updatedAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void goToNextScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offNamed(AppRouteName.interestSubjectView),
    );
  }
}
