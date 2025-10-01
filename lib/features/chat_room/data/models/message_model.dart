class MessageModel {
  final String message;
  final bool isMe;
  final String time;
  final bool isSeen;

  MessageModel({
    required this.message,
    required this.isMe,
    required this.time,
    required this.isSeen,
  });

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      isMe: map['isMe'] ?? false,
      time: map['time'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'isMe': isMe, 'time': time, 'isSeen': isSeen};
  }
}
