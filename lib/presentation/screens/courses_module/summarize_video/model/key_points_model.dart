class KeyPointsModel {
  int id = 0;
  String title = '';

  KeyPointsModel({required this.id, required this.title});

  factory KeyPointsModel.fromJson(Map<String, dynamic> json) {
    return KeyPointsModel(id: json['id'] ?? 0, title: json['title'] ?? '');
  }
}
