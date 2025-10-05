import 'package:equatable/equatable.dart';

class MyDetailsEntity extends Equatable {
  final int userID;
  final String fullName;
  final String email;
  final String brith;
  final String gender;
  final String phone;
  const MyDetailsEntity({
    required this.userID,
    required this.fullName,
    required this.email,
    required this.brith,
    required this.gender,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        userID,
        fullName,
        email,
        brith,
        gender,
        phone,
      ];
}
