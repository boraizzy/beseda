class AchievementModel {
  int id = 0;
  String name = '';
  String image = '';
  String description = '';
  AchievementModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
