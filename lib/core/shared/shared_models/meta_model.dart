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
