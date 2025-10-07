import 'package:pingora/core/shared/shared_models/user_model.dart';

class GetMeModel {
  final User? user;

  GetMeModel({this.user});

  factory GetMeModel.fromJson(Map<String, dynamic> json) {
    return GetMeModel(user: User.fromJson(json["user"] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {"user": user?.toJson() ?? {}};
  }
}
