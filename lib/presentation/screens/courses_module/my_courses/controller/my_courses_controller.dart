import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../home_module/home/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCoursesController extends GetxController {
  RxList<CourseModel> myCoursesList = <CourseModel>[].obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadMyCourses(); // ✅ Load saved courses on startup
  }

  /// Add a course if it’s not already in My Courses
  void addCourse(CourseModel course) {
    final exists = myCoursesList.any((c) => c.id == course.id);
    if (!exists) {
      // reset progress when adding the first time
      course.noOfCompletedLectures = 0;
      course.progressValue = 0.0;
      course.status = "In Progress";
      myCoursesList.add(course);

      saveCourses(); // ✅ persist to Firestore
    }
  }

  /// Mark a lecture as completed and update progress
  void markLectureAsCompleted(int courseId, int lectureId) {
    final courseIndex = myCoursesList.indexWhere((c) => c.id == courseId);
    if (courseIndex != -1) {
      final course = myCoursesList[courseIndex];

      // Prevent counting the same lecture twice
      course.completedLectures ??= {};
      if (course.completedLectures!.contains(lectureId)) return;

      course.completedLectures!.add(lectureId);
      course.noOfCompletedLectures = course.completedLectures!.length;

      // ✅ Update progress value
      if (course.noOfLectures > 0) {
        course.progressValue =
            course.noOfCompletedLectures / course.noOfLectures;
      }

      // ✅ Mark as completed if finished
      if (course.noOfCompletedLectures >= course.noOfLectures ||
          course.progressValue >= 1.0) {
        course.status = "Completed";
      }

      // ✅ Trigger UI refresh
      myCoursesList[courseIndex] = course;

      saveCourses(); // ✅ persist to Firestore
    }
  }

  /// Save courses to Firestore
  Future<void> saveCourses() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _db.collection("users").doc(user.uid).set({
        "myCourses": myCoursesList.map((c) => c.toJson()).toList(),
      }, SetOptions(merge: true));
    } catch (e) {
      if (kDebugMode) {
        print("Error saving courses: $e");
      }
    }
  }

  /// Load courses from Firestore
  Future<void> loadMyCourses() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final doc = await _db.collection("users").doc(user.uid).get();
      if (doc.exists && doc.data()!.containsKey("myCourses")) {
        final courses = (doc["myCourses"] as List)
            .map((e) => CourseModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        myCoursesList.assignAll(courses);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading courses: $e");
      }
    }
  }
}
