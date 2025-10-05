import 'package:shared_preferences/shared_preferences.dart';
import '../../injiction_container.dart' as di;

class SeenSecreen {
  Future<void> saveSeenScreen(String screenName) async {
    SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
    await sharedPreferences.setString("SEENSECREEN", screenName);
  }

  Future<String> getSeenScreen() {
    SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
    final seenSecreen = sharedPreferences.getString("SEENSECREEN");
    if (seenSecreen != null) {
      return Future.value(seenSecreen);
    } else {
      return Future.value("");
    }
  }
}
