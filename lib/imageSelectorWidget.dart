import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:app_vs/config/presentacion/screens/camera_screen.dart';
import 'package:app_vs/config/services/camera_implementation.dart';

class ImageSelectorWidget extends StatefulWidget {
  /// Callback opcional: recibe la ruta local de la imagen cada vez que cambia
  final void Function(String path)? onImageSelected;
  final String? initialImagePath;

  const ImageSelectorWidget({super.key, this.onImageSelected, this.initialImagePath});

  @override
  State<ImageSelectorWidget> createState() => _ImageSelectorWidgetState();
}

class _ImageSelectorWidgetState extends State<ImageSelectorWidget> {
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    imagePath = widget.initialImagePath ?? '';
  }

  Future<void> _captureWithCamera() async {
    final imagePathOverlay = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraScreen()),
    );
    if (imagePathOverlay != null) {
      setState(() => imagePath = imagePathOverlay);
      widget.onImageSelected?.call(imagePathOverlay);
    }
  }

  Future<void> _selectFromGallery() async {
    final photoPath = await CameraServicesImplementation().selectPhoto();
    if (photoPath == null) return;
    setState(() => imagePath = photoPath);
    widget.onImageSelected?.call(photoPath);
  }

  Widget _takeAPhoto(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        padding: const EdgeInsets.all(30),
        color: colors.primary,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        color: colors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.camera_alt_outlined),
              label: imagePath == '' ? const Text('Capturar una imagen') : const Text('Volver a tomar una imagen'),
              onPressed: _captureWithCamera,
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadAPhoto(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        padding: const EdgeInsets.all(30),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _selectFromGallery,
              icon: const Icon(Icons.upload_outlined),
              label: imagePath == '' ? const Text('Seleccionar una imagen') : const Text('Seleccionar otra una imagen'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showImageView() {
    if (imagePath == '') return const SizedBox.shrink();
    final file = File(imagePath);
    if (!file.existsSync()) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text("La imagen no existe o no se pudo cargar."),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Text('Imagen seleccionada', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Image.file(file, width: 350, height: 350, fit: BoxFit.cover),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          _showImageView(),
          const SizedBox(height: 20),
          Center(child: _takeAPhoto(context)),
          const SizedBox(height: 20),
          Center(child: _uploadAPhoto(context)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}