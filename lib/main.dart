import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لاستخدام SystemChrome
import 'package:provider/provider.dart';
import 'managers/preferences_manager.dart';
import 'managers/settings_manager.dart';
import 'screens/screen_editor.dart';

void main() async {
  // التأكد من تهيئة Flutter Bindings
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة PreferencesManager
  final preferencesManager = PreferencesManager();
  await preferencesManager.loadPreferences();

  // ضبط الاتجاه الافتراضي للوضع الأفقي
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsManager(preferencesManager),
        ),
      ],
      child: const LedBannerApp(),
    ),
  );
}

class LedBannerApp extends StatelessWidget {
  const LedBannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED Banner Scroller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      home: const ScreenEditor(),
    );
  }
}



 
