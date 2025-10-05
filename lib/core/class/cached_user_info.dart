import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/domain/entities/users.dart';
import '../../injiction_container.dart' as di;

class CachedUserInfo {
  Future<Unit> cachedUserInfo(UserEntite user) async {
    final sharedPreferences = di.sl<SharedPreferences>();
    sharedPreferences.setInt("USERID", user.userId!);
    sharedPreferences.setString("USEREMAIL", user.userEmail);
    sharedPreferences.setString("USERPHONE", user.userPhone ?? "0");
    sharedPreferences.setString("USERNAME", user.userFullName);
    sharedPreferences.setString("USERIMAGE", user.userImage ?? "empty");
    sharedPreferences.setString("BIRTH", user.birth!);
    sharedPreferences.setString("GENDER", user.gender!);
    return await Future.value(unit);
  }

  Future<UserEntite> getUserInfo() {
    final sharedPreferences = di.sl<SharedPreferences>();
    return Future.value(UserEntite(
      userId: sharedPreferences.getInt("USERID"),
      userEmail: sharedPreferences.getString("USEREMAIL")!,
      userPhone: sharedPreferences.getString("USERPHONE")!,
      userFullName: sharedPreferences.getString("USERNAME")!,
      userImage: sharedPreferences.getString("USERIMAGE"),
      birth: sharedPreferences.getString("BIRTH"),
      gender: sharedPreferences.getString("GENDER"),
    ));
  }
}
