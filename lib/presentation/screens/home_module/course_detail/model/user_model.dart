class UserModel {
  int id = 0;
  String name = '';
  String time = '';
  double rate = 0.0;
  String msg = '';

  UserModel({
    required this.id,
    required this.name,
    required this.time,
    required this.rate,
    required this.msg,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      time: json['time'] ?? '',
      rate: json['rate'] ?? 0.0,
      msg: json['msg'] ?? '',
    );
  }

  /// ✅ Added this
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "time": time,
      "rate": rate,
      "msg": msg,
    };
  }
}
