import 'dart:typed_data';

import 'package:app_vs/config/services/uplodad_image.dart';
import 'package:app_vs/imageSelectorWidget.dart';
import 'package:flutter/material.dart';

class ErosionScreen extends StatefulWidget {
  static const String name = 'ErosionScreen';
  const ErosionScreen({super.key});

  @override
  State<ErosionScreen> createState() => _ErosionScreenState();
}

class _ErosionScreenState extends State<ErosionScreen> {
  // Mover ksize aquí para que persista entre rebuilds
  int ksize = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erosión')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tamaño kernel (ksize)'),
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
                const SizedBox(height: 8),
                ImageSelectorWidget(
                  onImageSelected: (path) async {
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
                      // pasar ksize al servicio
                      final Uint8List? bytes = await UploadService.uploadImage('/erosion', path, ksize: ksize);
                      Navigator.of(context).pop(); // cerrar progreso
                      if (bytes == null) {
                        messenger.showSnackBar(const SnackBar(content: Text('No se recibió imagen procesada')));
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Resultado Erosión (ksize=$ksize)'),
                          content: Image.memory(bytes, width: 400, height: 400, fit: BoxFit.contain),
                          actions: [TextButton(
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
    );
  }
}