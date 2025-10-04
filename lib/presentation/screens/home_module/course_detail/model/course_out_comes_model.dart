class CourseOutComesModel {
  String image = '';
  String title = '';
  CourseOutComesModel({required this.image, required this.title});

  factory CourseOutComesModel.fromJson(Map<String, dynamic> json) {
    return CourseOutComesModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
    };
  }
}
