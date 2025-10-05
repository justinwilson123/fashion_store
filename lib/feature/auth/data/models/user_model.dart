import '../../domain/entities/users.dart';

class UserModel extends UserEntite {
  const UserModel({
    super.userId,
    super.userPassword,
    super.userImage,
    required super.userEmail,
    super.userPhone,
    required super.userFullName,
    super.gender,
    super.birth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userEmail: json['user_email'],
      userPhone: json['user_phone'] ?? "0",
      userImage: json['user_image'] ?? "empity",
      userFullName: json['user_full_name'],
      gender: json['gender'],
      birth: json['date_of_brith'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_email": userEmail,
      "user_password": userPassword,
      "user_phone": userPhone,
      "user_full_name": userFullName,
    };
  }
}
