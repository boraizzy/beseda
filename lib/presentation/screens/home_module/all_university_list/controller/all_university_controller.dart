import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../home/model/university_model.dart';
class AllUniversityController extends GetxController{
  RxList<UniversityModel> universityList = <UniversityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUniversityList();
  }
  void fetchAllUniversityList() async {
    universityList.clear();
    try {
      final data = await loadListFromAsset<UniversityModel>(
        AppJsonPath.allUniversity,
        'all_university_list',
            (json) => UniversityModel.fromJson(json),
      );

      universityList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error university_List : $e');
      }
    } finally {}
  }

}