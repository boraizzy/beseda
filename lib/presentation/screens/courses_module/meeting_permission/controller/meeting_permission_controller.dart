import 'package:get/get.dart';
class MeetingPermissionController extends GetxController{
  late String title;
  @override
  void onInit() {
    super.onInit();
    title=Get.arguments as String;
  }

}