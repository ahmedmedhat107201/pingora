import 'package:pingora/core/shared/shared_models/meta_model.dart';
import 'package:pingora/core/shared/shared_models/room_model.dart';

class GetRoomsModel {
  final Rooms? rooms;

  const GetRoomsModel({this.rooms});

  factory GetRoomsModel.fromJson(Map<String, dynamic> json) {
    return GetRoomsModel(rooms: Rooms.fromJson(json['rooms'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {"rooms": rooms?.toJson() ?? {}};
  }
}

class Rooms {
  final List<Room>? data;
  final Meta? meta;

  const Rooms({this.data, this.meta});

  factory Rooms.fromJson(Map<String, dynamic> json) {
    return Rooms(
      data:
          (json['data'] as List?)
              ?.map((e) => Room.fromJson(e ?? {}))
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
