import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class CameraScreen extends StatefulWidget {
  static const String name = 'camera_screen';
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  List<CameraDescription>? _cameras;
  int _cameraIndex = 0; // 0 = primera cámara, 1 = segunda cámara, etc.

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();

      // Garantizar que haya al menos una cámara
      final camera = _cameras![_cameraIndex];

      _controller = CameraController(
        camera,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      print("Error al inicializar la cámara: $e");
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    // Cambia el índice (0 → 1 → 0)
    _cameraIndex = (_cameraIndex + 1) % _cameras!.length;

    await _controller?.dispose(); // Cerrar cámara actual

    // Inicializar la nueva cámara
    _controller = CameraController(
      _cameras![_cameraIndex],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_controller == null || _initializeControllerFuture == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                SizedBox.expand(
                  child: CameraPreview(_controller!),
                ),

                // ✅ Botón para cambiar cámara
                Positioned(
                  top: 40,
                  right: 20,
                  child: FloatingActionButton(
                    heroTag: "switch_camera",
                    mini: true,
                    backgroundColor: colors.primary,
                    onPressed: _switchCamera,
                    child: const Icon(Icons.cameraswitch, color: Colors.white),
                  ),
                ),

                // ✅ Botón de tomar foto
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      heroTag: 'take_photo',
                      backgroundColor: colors.primary,
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          final picture = await _controller!.takePicture();

                          if (context.mounted) {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PreviewScreen(imagePath: picture.path),
                              ),
                            );

                            if (result != null && result is String) {
                              Navigator.pop(context, result);
                            }
                          }
                        } catch (e) {
                          print("Error al tomar foto: $e");
                        }
                      },
                      child: const Icon(Icons.camera, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vista previa")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen en la parte superior (toma todo el espacio disponible arriba)
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Center(
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio entre imagen y botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(2, 4), // desplazamiento
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text('Repetir',
                        style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Espacio entre botones
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(2, 4), // desplazamiento
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context, imagePath); // Confirmar imagen
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text('Confirmar',
                        style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),    
              ],
            ),
          ],
        ),
      ),
    );
  }
}