import 'dart:io';

import 'package:app_vs/config/menu/side_menu.dart';
import 'package:app_vs/config/presentacion/screens/camera_screen.dart';
import 'package:app_vs/config/services/camera_implementation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String imagePath = '';

Widget takeAPhoto(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        padding: EdgeInsets.all(30),
        color: colors.primary,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        color: colors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Si no hay imagen mostrar el icono de la camara, caso contrario mostrar el preview de la imagen
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: colors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.camera_alt_outlined),
              label: imagePath == ''
                  ? const Text('Capturar una imagen')
                  : const Text('Volver a tomar una imagen'),
              onPressed: () async {
                final imagePathOverlay = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CameraScreen()),
              );
              if (imagePathOverlay != null) {
                setState(() {
                  imagePath = imagePathOverlay;
                });
              }
              }, 
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadAPhoto(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        padding: EdgeInsets.all(30),
        color: colors.primary,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        color: colors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upload_file_outlined, color: Colors.white, size: 40),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: colors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                final photoPath =
                    await CameraServicesImplementation().selectPhoto();
                if (photoPath == null) return;
                photoPath;
                setState(() {
                  imagePath = photoPath;
                });
              },
              icon: const Icon(Icons.upload_outlined),
              label: imagePath == ''
                  ? const Text('Seleccionar una imagen')
                  : const Text('Seleccionar otra una imagen'),
            ),
          ],
        ),
      ),
    );
  }

  Widget showImageView() {
    if (imagePath == '') return const SizedBox.shrink();
    final file = File(imagePath);
    if (!file.existsSync()) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text("La imagen no existe o no se pudo cargar."),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
        const Text(
          'Imagen seleccionada',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Image.file(
          file,
          width: 350,
          height: 350,
          fit: BoxFit.cover,
        ),
      ],),
    );
  }

  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros de visión artificial'),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            showImageView(),
            const SizedBox(height: 20),
            Center(child: takeAPhoto(context)),
            const SizedBox(
              height: 20,
            ), 
            Center(child: uploadAPhoto(context)), 
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

