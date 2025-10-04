class DesignationModel {
  String name = '';
  String image = '';

  DesignationModel({required this.name, required this.image});

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
