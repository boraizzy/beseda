import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../course_category_detail/model/instructor_model.dart';
class TrainerProfileController extends GetxController{
  late InstructorModel data;
  Rx<InstructorModel> detail = InstructorModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    data=Get.arguments as InstructorModel;
    fetchTrainerProfileDetail();
  }
  void fetchTrainerProfileDetail() async {
    try {
      detail.value = await loadJsonFromAsset<InstructorModel>(
        AppJsonPath.trainerProfileDetail,
            (json) => InstructorModel.fromRawJson(jsonEncode(json)),
      );



    } catch (e) {
      if (kDebugMode) {
        print('Error loading Trainer Profile Detail: $e');
      }
    }
  }
}