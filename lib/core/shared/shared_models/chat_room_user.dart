import 'package:pingora/core/shared/shared_models/user_model.dart';

class ChatRoomUser {
  final int? chatRoomId;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  const ChatRoomUser({
    this.chatRoomId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ChatRoomUser.fromJson(Map<String, dynamic> json) {
    return ChatRoomUser(
      chatRoomId: json['chat_room_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chat_room_id": chatRoomId ?? 0,
      "user_id": userId ?? 0,
      "created_at": createdAt ?? "",
      "updated_at": updatedAt ?? "",
      "user": user?.toJson() ?? {},
    };
  }
}
