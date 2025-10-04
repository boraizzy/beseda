import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../model/key_points_model.dart';

class SummarizeVideoController extends GetxController{
RxList<KeyPointsModel> keyPointsList=<KeyPointsModel>[].obs;
@override
  void onInit() {
    super.onInit();
    fetchKeyPoints();
  }


void fetchKeyPoints() async {
  keyPointsList.clear();
  try {
    final data = await loadListFromAsset<KeyPointsModel>(
      AppJsonPath.summarizeVideo,
      'keyPoints',
          (json) => KeyPointsModel.fromJson(json),
    );

    keyPointsList.addAll(data);
  } catch (e) {
    if (kDebugMode) {
      print(' keyPointsList');
      print(keyPointsList);
      print('Error keyPointsList : $e');
    }
  } finally {}
}

}