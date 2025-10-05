import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';

class MyDetailsModel extends MyDetailsEntity {
  const MyDetailsModel({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.brith,
    required super.gender,
    required super.phone,
  });
  Map<String, dynamic> toJson() {
    return {
      "userID": userID.toString(),
      "fullName": fullName,
      "email": email,
      "birth": brith,
      "gender": gender,
      "phone": phone,
    };
  }
}
