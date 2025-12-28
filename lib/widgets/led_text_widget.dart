import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../managers/settings_manager.dart';
import '../models/led_config.dart';

class LedTextWidget extends StatelessWidget {
  const LedTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<SettingsManager>().currentConfig;

    // تحديد اتجاه النص المطلوب لمكتبة Marquee
    final Axis scrollAxis = Axis.horizontal;
    final TextDirection textDirection = config.direction == ScrollDirection.rtl
        ? TextDirection.rtl
        : TextDirection.ltr;

    // تحويل قيمة السرعة (0.0 - 1.0) إلى مدة بالثواني (مثلاً 10s بطيء - 2s سريع)
    final double scrollDuration = (1.0 - config.speed) * 8 + 2; 

    final textStyle = TextStyle(
      color: config.textColor,
      fontSize: 120.0, // حجم خط كبير جداً
      fontWeight: FontWeight.bold,
      shadows: const [
        // تأثير خفيف لإيحاء إضاءة LED
        Shadow(color: Colors.black, blurRadius: 4.0, offset: Offset(2, 2)),
      ],
    );

    Widget marqueeWidget = Marquee(
      text: config.text,
      velocity: 1000 / scrollDuration, // (بيكسل/ثانية)
      blankSpace: 50.0, // المسافة بين تكرارات النص
      startPadding: 20.0,
      scrollAxis: scrollAxis,
      textDirection: textDirection,
      style: textStyle,
      pauseAfterRound: const Duration(milliseconds: 500),
      // لا نحتاج لـ showFadingEdge: true لأنها ستكون إضاءة كاملة
    );

    // تطبيق تأثير الوميض (Blinking) إذا تم تفعيله
    if (config.isBlinking) {
      return BlinkingText(
        textStyle: textStyle.copyWith(color: config.textColor),
        child: marqueeWidget,
      );
    }

    return marqueeWidget;
  }
}

// --------------------- Widget مساعد لتأثير الوميض ---------------------

class BlinkingText extends StatefulWidget {
  final Widget child;
  final TextStyle textStyle;
  const BlinkingText({super.key, required this.child, required this.textStyle});

  @override
  State<BlinkingText> createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    // سرعة الوميض (يومض مرتين في الثانية)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), 
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }
}
