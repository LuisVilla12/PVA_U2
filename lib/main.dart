import 'package:app_vs/config/theme/app_theme.dart';
import 'package:camera/camera.dart';
import 'package:app_vs/config/router/app_router.dart';
import 'package:flutter/material.dart';
List<CameraDescription> cameras = [];

void main() async {
  // Obtiene el listado de lac camaras
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor =0; 
    final isDarkmode = false;

    return MaterialApp.router(
      // Define las rutas con GoRouter
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: selectedColor, isDarkmode: isDarkmode)
          .getTheme(),
    );
  }
}
