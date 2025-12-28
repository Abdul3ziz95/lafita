import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../managers/settings_manager.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  VideoPlayerController? _videoController;
  
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _initializeVideo(String assetPath) {
    // التأكد من التخلص من المتحكم القديم
    _videoController?.dispose(); 

    _videoController = VideoPlayerController.asset(assetPath)
      ..initialize().then((_) {
        // تشغيل الفيديو وتكراره
        _videoController!.play();
        _videoController!.setLooping(true); 
        setState(() {});
      }).catchError((error) {
        // التعامل مع الخطأ إذا لم يتم العثور على الملف
        _videoController = null;
      });
  }

  @override
  Widget build(BuildContext context) {
    final config = context.watch<SettingsManager>().currentConfig;

    // 1. إذا كان فيديو كخلفية
    if (config.isVideoBackground && config.backgroundAssetPath != null) {
      if (_videoController == null || _videoController!.dataSource != config.backgroundAssetPath) {
        _initializeVideo(config.backgroundAssetPath!);
      }
      
      if (_videoController != null && _videoController!.value.isInitialized) {
        return SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController!.value.size.width,
              height: _videoController!.value.size.height,
              child: VideoPlayer(_videoController!),
            ),
          ),
        );
      }
    }
    
    // 2. إذا كانت الخلفية لون ثابت (الافتراضي)
    return Container(
      color: config.backgroundColor,
    );
  }
}
