// Define los servicios de la cámara
abstract class CameraService {
  Future<String?> takePhoto();
  Future<String?> selectPhoto();
}