import 'dart:convert';

import 'package:lyrics_on_go/utils/type_def.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefRepository {
  SharedPreferences? _sharedPreferences;

  Future<JsonMap?> getJson(String key) async {
    final preferences = await _preferences;
    final rawValue = preferences.getString(key);
    if (rawValue == null) {
      return null;
    }
    return jsonDecode(rawValue);
  }

  Future<void> setJson(String key, JsonMap model) async {
    final preferences = await _preferences;
    preferences.setString(key, jsonEncode(model));
  }

  Future<SharedPreferences> get _preferences async {
    if (_sharedPreferences != null) {
      return _sharedPreferences!;
    }
    return await SharedPreferences.getInstance();
  }
}
