import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/led_config.dart';

class PreferencesManager {
  static const _configKey = 'led_banner_config';
  late SharedPreferences _prefs;

  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  LedConfig? getSavedConfig() {
    final jsonString = _prefs.getString(_configKey);
    if (jsonString != null) {
      try {
        final jsonMap = json.decode(jsonString);
        return LedConfig.fromJson(jsonMap);
      } catch (e) {
        // في حال فشل التحويل، ارجع قيمة فارغة
        return null;
      }
    }
    return null;
  }

  Future<void> saveConfig(LedConfig config) async {
    final jsonString = json.encode(config.toJson());
    await _prefs.setString(_configKey, jsonString);
  }
}
