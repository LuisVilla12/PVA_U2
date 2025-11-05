import 'dart:typed_data';

import 'package:app_vs/config/menu/side_menu.dart';
import 'package:app_vs/config/services/uplodad_image.dart';
import 'package:app_vs/imageSelectorWidget.dart';
import 'package:flutter/material.dart';

class CuatificacionScreen extends StatefulWidget {
  static const String name = 'CuatificacionScreen';
  const CuatificacionScreen({super.key});

  @override
  State<CuatificacionScreen> createState() => _CuatificacionScreenState();
}

class _CuatificacionScreenState extends State<CuatificacionScreen> {
    int ksize = 5;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>(); 
    // Pantalla para el filtro elemental cuantificación
    return Scaffold(
      appBar: AppBar(title: const Text('Cuantización de niveles')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tamaño kernel:', style: TextStyle(fontSize: 20)),
                      Text('$ksize'),
                    ],
                  ),
                  Slider(
                    value: ksize.toDouble(),
                    min: 1,
                    max: 31,
                    divisions: 30,
                    label: '$ksize',
                    onChanged: (v) => setState(() => ksize = v.round()),
                  ),
                  ImageSelectorWidget(
                    onImageSelected: (path) async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
                        // pasar ksize al servicio
                        final Uint8List? bytes = await UploadService.uploadImage('/cuantizacion', path, ksize: ksize);
                        Navigator.of(context).pop(); // cerrar progreso
                        if (bytes == null) {
                          messenger.showSnackBar(const SnackBar(content: Text('No se recibió imagen procesada')));
                          return;
                        }
              
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Preview Cuantificación (ksize=$ksize)'),
                            content: Image.memory(bytes, width: 400, height: 400, fit: BoxFit.contain),
                            actions: [
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () async {
                                  try {
                                    await UploadService.saveImageBytes(bytes, 'cuantificacion.png');
                                    messenger.showSnackBar(const SnackBar(content: Text('Imagen guardada correctamente')));
                                  } catch (e) {
                                    messenger.showSnackBar(SnackBar(content: Text('Error al guardar imagen: $e')));
                                  }
                                },
                              ),
                              TextButton(
                              onPressed: () => Navigator.of(context).pop(), child: const Text('Cerrar'))],
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop();
                        messenger.showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}