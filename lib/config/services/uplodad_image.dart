import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart'; // <-- agregado

// Servicio para subir imágenes al servidor
class UploadService {
  // Define la IP del servidor backend
  static const String baseUrl = 'http://10.0.2.2:8000';

  /// Función para subir una imagen al servidor
  static Future<Uint8List?> uploadImage(String endpoint, String filePath, {String mimeType = 'png', int ksize = 5}) async {
    final cleaned = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    final uri = Uri.parse('$baseUrl/$cleaned?ksize=$ksize');
    // Define el metodo HTTP y el contenido
    final request = http.MultipartRequest('POST', uri);
    final contentType = MediaType('image', mimeType);
    request.files.add(await http.MultipartFile.fromPath('sample_file', filePath, contentType: contentType));

    // Espera la peticion y maneja la respuesta
    final streamed = await request.send();
    if (streamed.statusCode == 200) {
      return await streamed.stream.toBytes();
    } else {
      final body = await streamed.stream.bytesToString();
      throw Exception('Server ${streamed.statusCode}: $body');
    }
  }
  
  // Guarda los bytes de la imagen en el almacenamiento local del dispositivo
  // Retorna la ruta del archivo guardado
static Future<String> saveImageBytes(Uint8List bytes, String filename) async {
    try {
      // Usar directorio de descargas o imágenes
      Directory? directory;
      if (Platform.isAndroid) {
        // En Android, guardar en Downloads
        directory = Directory('/storage/emulated/0/Download');
      } else {
        // En iOS u otros, usar documents
        directory = await getApplicationDocumentsDirectory();
      }

      // Crear subdirectorio para nuestra app
      final appDir = Directory('${directory.path}/app_vs_images');
      if (!await appDir.exists()) {
        await appDir.create(recursive: true);
      }

      // Guardar archivo con timestamp para evitar sobreescribir
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${appDir.path}/${timestamp}_$filename');
      await file.writeAsBytes(bytes);

      // print('Imagen guardada en: ${file.path}');
      return file.path;
    } catch (e) {
      // print('Error al guardar imagen: $e');
      rethrow;
    }
  }
}

