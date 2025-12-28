import 'package:flutter/material.dart';
import '../widgets/background_widget.dart';
import '../widgets/led_text_widget.dart';

class ScreenDisplay extends StatelessWidget {
  const ScreenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // إخفاء شريط الحالة وشريط التنقل لتقديم تجربة ملء الشاشة
    // يجب تطبيق SystemChrome لإخفائهما
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      body: GestureDetector(
        // عند النقر على الشاشة، نعود إلى شاشة التحرير
        onTap: () {
          // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // إرجاع الواجهة
          Navigator.pop(context);
        },
        child: const Stack(
          children: [
            // الطبقة السفلية: الخلفية (اللون أو الفيديو)
            BackgroundWidget(),
            
            // الطبقة العلوية: النص المتحرك
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: 1000, // مساحة كافية للتمرير
                    height: 180, 
                    child: LedTextWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
