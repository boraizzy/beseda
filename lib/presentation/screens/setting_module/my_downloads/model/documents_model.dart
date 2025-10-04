class DocumentsModel {
  int id = 0;
  String name = '';
  String date = '';
  int storage = 0;

  DocumentsModel({
    required this.id,
    required this.name,
    required this.date,
    required this.storage,
  });

  factory DocumentsModel.fromJson(Map<String, dynamic> json) {
    return DocumentsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      storage: json['storage'] ?? 0,
    );
  }
}
