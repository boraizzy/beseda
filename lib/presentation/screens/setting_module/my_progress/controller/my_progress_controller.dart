import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../model/my_progress_model.dart';

class MyProgressController extends GetxController {
  Rx<MyProgressModel> detail = MyProgressModel.empty().obs;



  @override
  void onInit() {
    super.onInit();

    fetchMyProgressDetail();
  }

  void fetchMyProgressDetail() async {
    try {
      detail.value = await loadJsonFromAsset<MyProgressModel>(
        AppJsonPath.myProgress,
        (json) => MyProgressModel.fromRawJson(jsonEncode(json)),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading course detail: $e');
      }
    }
  }


}
