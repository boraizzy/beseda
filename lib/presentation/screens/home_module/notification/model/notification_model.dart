class NotificationModel {
  String date='';
  List<NotificationListModel> messagesList = [];

  NotificationModel({required this.date,});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = json['date'];
    }
    if (json['messages'] != null) {
      messagesList = List<dynamic>.from(json['messages'])
          .map((i) => NotificationListModel.fromJson(i))
          .toList();
    }

  }
}

class NotificationListModel {
  int id = 0;
  String title = '';
  String msg = '';
  bool marAsRead =false;

  NotificationListModel({
    required this.id,
    required this.title,
    required this.msg,
    required this.marAsRead,

  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) {
    return NotificationListModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      msg: json['msg'] ?? '',
      marAsRead: json['marAsRead'] ?? false,

    );
  }
}
