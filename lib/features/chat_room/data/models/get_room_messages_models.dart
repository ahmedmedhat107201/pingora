import 'package:pingora/core/shared/shared_models/message_model.dart';
import 'package:pingora/core/shared/shared_models/meta_model.dart';

class GetRoomMessagesModel {
  final Messages? messages;

  const GetRoomMessagesModel({this.messages});

  factory GetRoomMessagesModel.fromJson(Map<String, dynamic> json) {
    return GetRoomMessagesModel(
      messages: Messages.fromJson(json['messages'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {"messages": messages?.toJson() ?? {}};
  }
}

class Messages {
  final List<MessageModel>? data;
  final Meta? meta;

  const Messages({this.data, this.meta});

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      data:
          (json['data'] as List?)
              ?.map((e) => MessageModel.fromJson(e ?? {}))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data?.map((e) => e.toJson()).toList() ?? [],
      "meta": meta?.toJson() ?? {},
    };
  }
}
