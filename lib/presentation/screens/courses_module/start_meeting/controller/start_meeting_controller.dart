import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../model/participants_model.dart';


class StartMeetingController extends GetxController{
  RxList<ParticipantsModel> usersList=<ParticipantsModel>[].obs;
  var handsUp=false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUsersList();
  }


  void fetchUsersList() async {
    usersList.clear();
    try {
      final data = await loadListFromAsset<ParticipantsModel>(
        AppJsonPath.usersMeetingList,
        'users_meeting_list',
            (json) => ParticipantsModel.fromJson(json),
      );

      usersList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print(' keyPointsList');
        print(usersList);
        print('Error keyPointsList : $e');
      }
    } finally {}
  }
  void handsUpOrNot(){
    handsUp.value=!handsUp.value;
  }

}