import 'package:equatable/equatable.dart';

class UserEntite extends Equatable {
  final int? userId;
  final String userEmail;
  final String? userPhone;
  final String? userImage;
  final String userFullName;
  final String? userPassword;
  final String? gender;
  final String? birth;

  const UserEntite({
    this.userId,
    this.userPassword,
    required this.userEmail,
    this.userPhone,
    this.userImage,
    required this.userFullName,
    this.gender,
    this.birth,
  });

  @override
  List<Object?> get props => [
        userId,
        userEmail,
        userPhone,
        userImage,
        userFullName,
        userPassword,
        gender,
        birth,
      ];
}
