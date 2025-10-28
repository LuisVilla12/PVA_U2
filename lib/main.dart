import 'package:camera/camera.dart';
import 'package:app_vs/config/router/app_router.dart';
import 'package:flutter/material.dart';
List<CameraDescription> cameras = [];

void main() async {
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
