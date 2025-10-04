class LecturesModel {
  int id = 0;
  String name = '';
  String timeOfVideo = '';
  bool isDownloaded=false;
  bool isCompleted=false;
  LecturesModel({required this.id,required this.name, required this.timeOfVideo,required this.isDownloaded,
    required this.isCompleted,});

  factory LecturesModel.fromJson(Map<String, dynamic> json) {
    return LecturesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      timeOfVideo: json['timeOfVideo'] ?? '',
      isDownloaded: json['isDownloaded'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "timeOfVideo": timeOfVideo,
      "isDownloaded": isDownloaded,
      "isCompleted": isCompleted,
    };
  }
}
