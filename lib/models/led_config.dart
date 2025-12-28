import 'package:flutter/material.dart';

enum ScrollDirection { ltr, rtl } // يسار ليمين، يمين ليسار

@immutable
class LedConfig {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double speed;
  final bool isBlinking;
  final ScrollDirection direction;
  final String? backgroundAssetPath; 
  final bool isVideoBackground;

  const LedConfig({
    this.text = 'مرحباً في شاشة LED',
    this.textColor = Colors.red,
    this.backgroundColor = Colors.black,
    this.speed = 0.5,
    this.isBlinking = false,
    this.direction = ScrollDirection.rtl,
    this.backgroundAssetPath,
    this.isVideoBackground = false,
  });

  // لتحويل الكائن إلى Map لتخزينه في SharedPreferences
  Map<String, dynamic> toJson() => {
        'text': text,
        'textColor': textColor.value,
        'backgroundColor': backgroundColor.value,
        'speed': speed,
        'isBlinking': isBlinking,
        'direction': direction.name,
        'backgroundAssetPath': backgroundAssetPath,
        'isVideoBackground': isVideoBackground,
      };

  // لتحويل Map إلى كائن LedConfig
  factory LedConfig.fromJson(Map<String, dynamic> json) {
    return LedConfig(
      text: json['text'] as String,
      textColor: Color(json['textColor'] as int),
      backgroundColor: Color(json['backgroundColor'] as int),
      speed: json['speed'] as double,
      isBlinking: json['isBlinking'] as bool,
      direction: ScrollDirection.values.byName(json['direction'] as String),
      backgroundAssetPath: json['backgroundAssetPath'] as String?,
      isVideoBackground: json['isVideoBackground'] as bool,
    );
  }

  LedConfig copyWith({
    String? text,
    Color? textColor,
    Color? backgroundColor,
    double? speed,
    bool? isBlinking,
    ScrollDirection? direction,
    String? backgroundAssetPath,
    bool? isVideoBackground,
  }) {
    return LedConfig(
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      speed: speed ?? this.speed,
      isBlinking: isBlinking ?? this.isBlinking,
      direction: direction ?? this.direction,
      backgroundAssetPath: backgroundAssetPath ?? this.backgroundAssetPath,
      isVideoBackground: isVideoBackground ?? this.isVideoBackground,
    );
  }
}
