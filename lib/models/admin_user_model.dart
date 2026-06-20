class AdminUserModel {
  const AdminUserModel({
    required this.username,
    required this.password,
    required this.name,
    required this.role,
  });

  final String username;
  final String password;
  final String name;
  final String role;
}
