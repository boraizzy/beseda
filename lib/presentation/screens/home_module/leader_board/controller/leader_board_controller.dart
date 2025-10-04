import 'package:education_app/presentation/screens/home_module/leader_board/model/leader_board_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';

class LeaderBoardController extends GetxController {
  RxList<LeaderBoardModel> leaderList = <LeaderBoardModel>[].obs;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    fetchLeaderListDetail();
  }

  final RxBool findMe = false.obs;
  final RxBool showBackToTop = false.obs;

  final RxInt currentPage = 1.obs;
  final int rowsPerPage = 10;


  List<LeaderBoardModel> get pagedList {
    final start = (currentPage.value - 1) * rowsPerPage;
    final end = (start + rowsPerPage) > leaderList.length
        ? leaderList.length
        : (start + rowsPerPage);
    return leaderList.sublist(start, end);
  }

  int get totalPages => (leaderList.length / rowsPerPage).ceil();

  void fetchLeaderListDetail() async {
    leaderList.clear();
    try {
      final data = await loadListFromAsset<LeaderBoardModel>(
        AppJsonPath.leaderBoard,
        'leader_board_list',
            (json) => LeaderBoardModel.fromJson(json),
      );
      leaderList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error leader_board_list : $e');
      }
    }
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void findUser() {
    const targetName = "Davon Johan";

    final index = leaderList.indexWhere((e) => e.name == targetName);
    if (index != -1) {
      // Found the user, go to their page
      final page = (index ~/ rowsPerPage) + 1;
      currentPage.value = page;
      findMe.value = true;
      showBackToTop.value = true;

      // Scroll to top of that page
      Future.delayed(Duration(milliseconds: 300), () {
        scrollToTop();
      });
    }
  }

  void backToTop() {
    currentPage.value = 1;
    scrollToTop();
    findMe.value = false;
    showBackToTop.value = false;
  }

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
