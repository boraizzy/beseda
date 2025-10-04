enum MessageType { text, image, video, document}

class MessageModel {
  int? id;
  String content;
  String name;
  String image;
  MessageType type;
  String time;
  bool isSender;
  MessageModel? replyTo;
  final String? fileName;
  int? fileSize;
  MessageModel({
    required this.id,
    required this.content,
    required this.name,
    required this.image,
    required this.type,
    required this.time,
    required this.isSender,
    this.replyTo,
    this.fileName,
    this.fileSize
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      type: _parseMessageType(json['type']),
      time: json['time'] ?? '',
      isSender: json['isSender'] ?? false,
      replyTo: json['replyTo'] != null
          ? MessageModel.fromJson(json['replyTo'])
          : null,
      fileName: json['fileName'] ?? '',
      fileSize: json['fileSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'name': name,
      'image': image,
      'type': type.name,
      'time': time,
      'isSender': isSender,
      'replyTo': replyTo?.toJson(),
    };
  }

  static MessageType _parseMessageType(dynamic value) {
    if (value is String) {
      return MessageType.values.firstWhere(
            (e) => e.name == value,
        orElse: () => MessageType.text,
      );
    } else if (value is int) {
      return MessageType.values[value];
    }
    return MessageType.text;
  }
}
