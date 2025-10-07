import 'package:pingora/core/shared/shared_models/meta_model.dart';
import 'package:pingora/core/shared/shared_models/user_model.dart';

class GetUsersModel {
  final Users? users;

  const GetUsersModel({this.users});

  factory GetUsersModel.fromJson(Map<String, dynamic> json) {
    return GetUsersModel(users: Users.fromJson(json['users'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {"users": users?.toJson() ?? {}};
  }
}

class Users {
  final List<User>? data;
  final Meta? meta;

  const Users({this.data, this.meta});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      data:
          (json['data'] as List?)
              ?.map((e) => User.fromJson(e ?? {}))
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
