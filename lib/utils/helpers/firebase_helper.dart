import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../presentation/screens/home_module/quiz_list/model/quiz_model.dart';

Future<void> initializeMockTestsForUser(String uid) async {
  final doc = FirebaseFirestore.instance.collection('users').doc(uid);

  // Check if mockTests already exists
  final snapshot = await doc.get();
  if (snapshot.data()?['mockTests'] != null) {
    return; // already initialized
  }

  // Load quizzes from your JSON asset
  final raw = await rootBundle.loadString('assets/your_path/mock_tests.json');
  final map = jsonDecode(raw) as Map<String, dynamic>;
  final list = (map['mock_Test_List'] as List<dynamic>? ?? [])
      .map((e) => QuizModel.fromJson(e as Map<String, dynamic>))
      .toList();

  // Build initial map with all quizzes Pending
  final mockTests = {
    for (final quiz in list) quiz.id.toString(): "Pending",
  };

  // Save to Firestore
  await doc.set({"mockTests": mockTests}, SetOptions(merge: true));
}
