class UserModel {
  final int userId;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }

  
}
