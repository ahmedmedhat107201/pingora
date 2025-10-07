import 'package:pingora/core/shared/shared_models/chat_room_user.dart';
import 'package:pingora/core/shared/shared_models/message_model.dart';

class Room {
  final int? id;
  final String? type;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final MessageModel? lastMessage;
  final List<ChatRoomUser>? chatRoomUsers;
  final String? coverImageUrl;
  final String? displayName;

  const Room({
    this.id,
    this.type,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.chatRoomUsers,
    this.coverImageUrl,
    this.displayName,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? 0,
      type: json['type'] ?? "",
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'])
          : null,
      chatRoomUsers:
          (json['chat_room_users'] as List?)
              ?.map((e) => ChatRoomUser.fromJson(e ?? {}))
              .toList() ??
          [],
      coverImageUrl: json['coverImageUrl'] ?? json['cover_image_url'] ?? "",
      displayName: json['display_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "type": type ?? "",
      "is_active": isActive ?? false,
      "created_at": createdAt ?? "",
      "updated_at": updatedAt ?? "",
      "last_message": lastMessage?.toJson() ?? {},
      "chat_room_users": chatRoomUsers?.map((e) => e.toJson()).toList() ?? [],
      "cover_image_url": coverImageUrl ?? "",
      "display_name": displayName ?? "",
    };
  }
}
