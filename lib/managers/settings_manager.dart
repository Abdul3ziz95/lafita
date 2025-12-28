
import 'package:flutter/material.dart';
import '../models/led_config.dart';
import 'preferences_manager.dart';

class SettingsManager with ChangeNotifier {
  final PreferencesManager _preferencesManager;

  // الإعداد الافتراضي
  LedConfig _currentConfig = const LedConfig();

  LedConfig get currentConfig => _currentConfig;

  SettingsManager(this._preferencesManager) {
    _currentConfig = _preferencesManager.getSavedConfig() ?? _currentConfig;
  }

  void updateText(String newText) {
    _currentConfig = _currentConfig.copyWith(text: newText);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void updateTextColor(Color newColor) {
    _currentConfig = _currentConfig.copyWith(textColor: newColor);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void updateBackgroundColor(Color newColor) {
    _currentConfig = _currentConfig.copyWith(backgroundColor: newColor);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void updateSpeed(double newSpeed) {
    _currentConfig = _currentConfig.copyWith(speed: newSpeed);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void toggleBlinking(bool isBlinking) {
    _currentConfig = _currentConfig.copyWith(isBlinking: isBlinking);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }
  
  void updateDirection(ScrollDirection direction) {
    _currentConfig = _currentConfig.copyWith(direction: direction);
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void setBackgroundAsset(String? path, bool isVideo) {
    _currentConfig = _currentConfig.copyWith(
      backgroundAssetPath: path,
      isVideoBackground: isVideo,
    );
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }

  void resetBackground() {
    _currentConfig = _currentConfig.copyWith(
      backgroundAssetPath: null,
      isVideoBackground: false,
    );
    notifyListeners();
    _preferencesManager.saveConfig(_currentConfig);
  }
}
