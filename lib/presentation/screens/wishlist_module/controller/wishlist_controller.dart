import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_json_path.dart';
import '../../../../utils/extensions/json_helper.dart';
import '../../home_module/home/model/course_model.dart';

class WishlistController extends GetxController {
  RxList<CourseModel> wishList = <CourseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // fetchWishlistDetail();
  }

  // Load initial wishlist from assets (optional, for demo/stub data)
  Future<void> fetchWishlistDetail() async {
    wishList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.wishlist,
        'wishlist',
        (json) => CourseModel.fromJson(json),
      );

      // Ensure all loaded items are marked as favourite
      for (var item in data) {
        item.isFavourite.value = true;
      }

      // Merge uniquely by id to avoid duplicates
      for (final item in data) {
        if (!_containsId(item.id)) {
          wishList.add(item);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading wishlist: $e');
      }
    }
  }

  // Add/remove a course from wishlist
  bool toggleWishlist(CourseModel course) {
    final alreadyIn = _containsId(course.id);
    if (alreadyIn) {
      // remove
      _removeById(course.id);
      course.isFavourite.value = false;
      return false; // removed
    } else {
      // add
      wishList.add(course);
      course.isFavourite.value = true;
      return true; // added
    }
  }

  // Check if a course is in wishlist
  bool isInWishlist(int id) => _containsId(id);

  // Helpers
  bool _containsId(int id) => wishList.any((c) => c.id == id);

  void _removeById(int id) {
    final idx = wishList.indexWhere((c) => c.id == id);
    if (idx != -1) wishList.removeAt(idx);
  }
}
