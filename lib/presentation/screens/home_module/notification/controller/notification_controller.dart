import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../../../common_widgets/alerts/alerts.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchNotificationList();
  }

  void fetchNotificationList() async {
    notificationList.clear();
    try {
      final data = await loadListFromAsset<NotificationModel>(
        AppJsonPath.notification,
        'notificationList',
        (json) => NotificationModel.fromJson(json),
      );

      notificationList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error on_Going_Courses : $e');
      }
    } finally {}
  }

  void deleteNotification(int mainIndex, index, BuildContext context) {
    notificationList[mainIndex].messagesList.removeAt(index);

    if (notificationList[mainIndex].messagesList.isEmpty) {
      notificationList.removeAt(mainIndex);
    }

    notificationList.refresh();

    showSuccessMessage(
      context: context,
      title: NotificationViewStrings.notificationDeleteSuccessfully,
      content: '',
    );
  }

  void toggleReadStatus(int mainIndex, int index, BuildContext context) {
    final current = notificationList[mainIndex].messagesList[index];
    current.marAsRead = !current.marAsRead;
    notificationList.refresh();
    showSuccessMessage(
      context: context,
      title: current.marAsRead
          ? NotificationViewStrings.notificationMarkAsReadSuccessfully
          : NotificationViewStrings.notificationMarkAsUnReadSuccessfully,
      content: '',
    ); // notify UI
  }
}
