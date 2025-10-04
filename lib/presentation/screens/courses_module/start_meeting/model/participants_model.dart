import 'dart:convert';

class ParticipantsModel {
  int id = 0;
  String name = '';
  String image = '';
  bool showMe=false;
  bool speaking=false;
  List<ParticipantsModel> hostList = [];
  List<ParticipantsModel> participantsList = [];

  ParticipantsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.hostList,
    required this.participantsList,
    required this.showMe,
    required this.speaking,
  });
  ParticipantsModel.empty();
  factory ParticipantsModel.fromRawJson(String str) =>
      ParticipantsModel.fromJson(json.decode(str));
  factory ParticipantsModel.fromJson(Map<String, dynamic> json) {
    return ParticipantsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      hostList:
          (json['host_list'] as List<dynamic>?)
              ?.map((e) => ParticipantsModel.fromJson(e))
              .toList() ??
          [],
      participantsList:
          (json['participants_list'] as List<dynamic>?)
              ?.map((e) => ParticipantsModel.fromJson(e))
              .toList() ??
          [],
      showMe: json['showMe'] ?? false,
      speaking: json['speaking'] ?? false,
    );
  }
}
