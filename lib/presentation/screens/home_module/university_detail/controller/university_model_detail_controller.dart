import 'dart:convert';
import 'package:education_app/presentation/screens/home_module/home/model/university_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';

class UniversityModelDetailController extends GetxController {
  late UniversityModel data;
  Rx<UniversityModel> detail = UniversityModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments as UniversityModel;
    fetchUniversityDetail();
  }

  void fetchUniversityDetail() async {
    try {
      detail.value = await loadJsonFromAsset<UniversityModel>(
        AppJsonPath.universityDetail,
        (json) => UniversityModel.fromRawJson(jsonEncode(json)),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading Trainer Profile Detail: $e');
      }
    }
  }
}
