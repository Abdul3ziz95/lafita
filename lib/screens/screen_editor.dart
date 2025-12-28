import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../managers/settings_manager.dart';
import '../models/led_config.dart';
import 'screen_display.dart';

class ScreenEditor extends StatelessWidget {
  const ScreenEditor({super.key});

  void _showColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اختر اللون'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.8,
            displayThumbColor: true,
            paletteType: PaletteType.hsv,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('تم'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<SettingsManager>();
    final config = manager.currentConfig;
    final textController = TextEditingController(text: config.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُحرر لافتة LED'),
        actions: [
          // زر العرض (Preview/Display)
          TextButton.icon(
            icon: const Icon(Icons.screen_rotation, color: Colors.white),
            label: const Text('عرض', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScreenDisplay()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. إدخال النص
            TextField(
              controller: textController,
              onChanged: manager.updateText,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'النص المراد عرضه',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.edit),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // 2. التحكم في السرعة
            const Text('سرعة التمرير', style: TextStyle(fontSize: 16)),
            Slider(
              value: config.speed,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: (config.speed * 10).round().toString(),
              onChanged: manager.updateSpeed,
            ),

            // 3. خيارات التخصيص (لون، وميض، اتجاه)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // لون النص
                TextButton.icon(
                  icon: Icon(Icons.colorize, color: config.textColor),
                  label: const Text('لون النص'),
                  onPressed: () => _showColorPicker(
                    context,
                    config.textColor,
                    manager.updateTextColor,
                  ),
                ),
                // لون الخلفية
                TextButton.icon(
                  icon: Icon(Icons.square, color: config.backgroundColor),
                  label: const Text('لون الخلفية'),
                  onPressed: () => _showColorPicker(
                    context,
                    config.backgroundColor,
                    manager.updateBackgroundColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 4. الوميض والاتجاه
            SwitchListTile(
              title: const Text('تأثير الوميض (Blinking)'),
              value: config.isBlinking,
              onChanged: manager.toggleBlinking,
              secondary: const Icon(Icons.flash_on),
            ),
            
            const Divider(),
            
            // 5. اتجاه التمرير
            const Text('اتجاه التمرير', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<ScrollDirection>(
                    title: const Text('يمين لليسار'),
                    value: ScrollDirection.rtl,
                    groupValue: config.direction,
                    onChanged: (val) => manager.updateDirection(val!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<ScrollDirection>(
                    title: const Text('يسار لليمين'),
                    value: ScrollDirection.ltr,
                    groupValue: config.direction,
                    onChanged: (val) => manager.updateDirection(val!),
                  ),
                ),
              ],
            ),
            const Divider(),
            
            // 6. خلفيات الفيديو (مثال بسيط)
            const Text('خلفية الفيديو (تجريبي)', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.videocam),
                  label: const Text('تعيين فيديو'),
                  onPressed: () => manager.setBackgroundAsset('assets/sample_video.mp4', true),
                ),
                const SizedBox(width: 10),
                TextButton(
                  child: const Text('إزالة الخلفية'),
                  onPressed: manager.resetBackground,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
