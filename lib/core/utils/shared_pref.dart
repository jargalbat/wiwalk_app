import 'package:shared_preferences/shared_preferences.dart';

import 'func.dart';

late SharedPreferences sharedPref;

class SharedPrefKeys {
  // Global
  static const String themeMode = 'themeMode';
  static const String showIntro = 'showIntro';
  static const String biometricAuth = 'biometricAuth';
  static const String accessToken = 'accessToken';
}

class SharedPrefHelper {
  // static String getAccessToken() {
  //   return sharedPref.getString(SharedPrefKeys.accessToken) ?? '';
  // }
  //
  // static void setAccessToken(String? accessToken) {
  //   sharedPref.setString(SharedPrefKeys.accessToken, Func.toStr(accessToken));
  // }
}
