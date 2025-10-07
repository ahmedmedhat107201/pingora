import 'package:pingora/core/shared/shared_models/user_model.dart';

class MessageModel {
  final int? id;
  final String? content;
  final String? type;
  final int? roomId;
  final int? senderId;
  final String? createdAt;
  final String? updatedAt;
  final String? attachments;
  final User? sender;
  final bool? isMine;

  const MessageModel({
    this.id,
    this.content,
    this.type,
    this.roomId,
    this.senderId,
    this.createdAt,
    this.updatedAt,
    this.attachments,
    this.sender,
    this.isMine,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? "",
      type: json['type'] ?? "",
      roomId: json['room_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      attachments: json['attachments'] ?? "",
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      isMine: json['is_mine'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "content": content ?? "",
      "type": type ?? "",
      "room_id": roomId ?? 0,
      "sender_id": senderId ?? 0,
      "created_at": createdAt ?? "",
      "updated_at": updatedAt ?? "",
      "attachments": attachments ?? "",
      "sender": sender?.toJson() ?? {},
      "is_mine": isMine ?? false,
    };
  }
}
