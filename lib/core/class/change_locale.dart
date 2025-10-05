import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../injiction_container.dart' as di;

class ChangeLocale {
  Future<Unit> saveLocale(String langCode) async {
    final sharedPreferences = di.sl<SharedPreferences>();
    sharedPreferences.setString("LOCALE", langCode);
    return await Future.value(unit);
  }

  Future<String> getLocale() async {
    final sharedPreferences = di.sl<SharedPreferences>();
    final langCode = sharedPreferences.getString("LOCALE");
    if (langCode != null) {
      return await Future.value(langCode);
    } else {
      return await Future.value("");
    }
  }
}
