
import 'package:app_vs/config/services/camera_service.dart';
import 'package:image_picker/image_picker.dart';

// Servicio de la cámara utilizando la librería image_picker
class CameraServicesImplementation extends CameraService{
  final ImagePicker picker = ImagePicker();
  // Funcion para seleccionar foto de la galería
  @override
  Future<String?> selectPhoto()async {
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery, 
      // Calidad de la imagen
      imageQuality: 10,
      // Seleccionar que camara prefiere
      preferredCameraDevice: CameraDevice.rear);
      if(photo==null) return null;
      return photo.path;
  }
  // Funcion para tomar foto con la cámara
  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera, 
      // Calidad de la imagen
      imageQuality: 80,
      // Que camara prefiere
      preferredCameraDevice: CameraDevice.rear);
      if(photo==null) return null;
      return photo.path;
  }
}