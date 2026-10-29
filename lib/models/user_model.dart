class UserModel {
  final String fullName;
  final String email;
  final String password;
  final DateTime createdAt;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
