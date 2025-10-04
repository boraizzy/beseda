import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../start_meeting/model/participants_model.dart';


class ParticipantsListController extends GetxController{

  Rx<ParticipantsModel> detail = ParticipantsModel.empty().obs;
  var searchController = TextEditingController();
  var handsUp=false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchParticipantsDetail();

  }
  void fetchParticipantsDetail() async {
    try {
      detail.value = await loadJsonFromAsset<ParticipantsModel>(
        AppJsonPath.participantsList,
            (json) => ParticipantsModel.fromRawJson(jsonEncode(json)),
      );



    } catch (e) {
      if (kDebugMode) {
        print('Error loading single course detail: $e');
      }
    }
  }



}