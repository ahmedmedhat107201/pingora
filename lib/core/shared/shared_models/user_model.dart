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
