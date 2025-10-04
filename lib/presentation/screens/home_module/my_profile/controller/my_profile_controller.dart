import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io'; // for File
import 'package:firebase_storage/firebase_storage.dart';
import '../model/user_profile_model.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';

class MyProfileController extends GetxController {
  Rx<UserProfileModel> userData = UserProfileModel
      .empty()
      .obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Load static JSON (for courses, coins, etc.)
      final localProfile = await loadJsonFromAsset<UserProfileModel>(
        AppJsonPath.userProfile,
            (json) => UserProfileModel.fromRawJson(jsonEncode(json)),
      );

      User? user = _auth.currentUser;

      if (user != null) {
        // Fetch Firestore user document
        final doc = await _db.collection("users").doc(user.uid).get();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;

          // Override name and email with Firestore values
          localProfile.name = data["name"] ?? localProfile.name;
          localProfile.email = data["email"] ?? localProfile.email;

          // If Firestore has a profile image URL, use it
          if (data["profile_url"] != null) {
            localProfile.profileUrl = data["profile_url"];
          }
        }
      }

      userData.value = localProfile;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user profile: $e');
      }
    }
  }

  /// Save new profile image and persist it locally

  Future<void> updateProfileImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      // 1. Upload to Firebase Storage (with metadata)
      final storageRef =
      FirebaseStorage.instance.ref().child("profile_pictures/${user.uid}.jpg");

      await storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: "image/jpeg"),
      );

      final url = await storageRef.getDownloadURL();

      // 2. Save URL to Firestore
      await _db.collection("users").doc(user.uid).update({"profile_url": url});

      // 3. Update locally (use value assignment instead of update)
      userData.value = userData.value.copyWith(profileUrl: url);

      // 4. (Optional but safer) Refresh from Firestore to stay in sync
      await fetchUserData();
    } catch (e) {
      if (kDebugMode) print("Error updating profile picture: $e");
    }
  }
}