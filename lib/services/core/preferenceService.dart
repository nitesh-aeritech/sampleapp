import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Singleton instance of the shared preferences
class PreferenceService {
  static PreferenceService? _instance;
  static late SharedPreferences _prefs;

  static ValueNotifier<bool> isReady = ValueNotifier(false);

  PreferenceService._() {
    SharedPreferences.getInstance().then(
      (prefs) {
        _prefs = prefs;
        isReady.value = true;
      },
    );
  }

  factory PreferenceService() {
    _instance ??= PreferenceService._();
    return _instance!;
  }

  // ///User accessToken from server
  String get accessToken => (_prefs.getString('accessToken') ?? '');
  set accessToken(String value) => _prefs.setString('accessToken', value);

  ///User's full name registered in server
  String? get userName => _prefs.getString('userName');
  set userName(String? value) => _prefs.setString('userName', value ?? '');

  Future<void> clearSession() async {
    await _prefs.remove('accessToken');
  }
}
