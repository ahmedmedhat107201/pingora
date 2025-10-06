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

class Meta {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  const Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total": total ?? 0,
      "per_page": perPage ?? 0,
      "current_page": currentPage ?? 0,
      "last_page": lastPage ?? 0,
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final String? location;
  final String? websites;
  final String? bio;
  final String? profileImageUrl;
  final String? coverImageUrl;

  const User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.websites,
    this.bio,
    this.profileImageUrl,
    this.coverImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      role: json['role'] ?? "",
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      location: json['location'] ?? "",
      websites: json['websites'] ?? "",
      bio: json['bio'] ?? "",
      profileImageUrl:
          json['profileImageUrl'] ?? json['profile_image_url'] ?? "",
      coverImageUrl: json['coverImageUrl'] ?? json['cover_image_url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "name": name ?? "",
      "email": email ?? "",
      "role": role ?? "",
      "is_active": isActive ?? false,
      "created_at": createdAt ?? "",
      "updated_at": updatedAt ?? "",
      "location": location ?? "",
      "websites": websites ?? "",
      "bio": bio ?? "",
      "profile_image_url": profileImageUrl ?? "",
      "cover_image_url": coverImageUrl ?? "",
    };
  }
}
