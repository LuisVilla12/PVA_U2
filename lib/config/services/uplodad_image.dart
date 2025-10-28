import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadService {
  // Cambia por la IP/host de tu servidor
  static const String baseUrl = 'http://10.0.2.2:8000';

  /// endpoint puede ser '/erosion' o 'erosion'
  static Future<Uint8List?> uploadImage(String endpoint, String filePath, {String mimeType = 'png', int ksize = 5}) async {
    final cleaned = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    final uri = Uri.parse('$baseUrl/$cleaned?ksize=$ksize');

    final request = http.MultipartRequest('POST', uri);
    final contentType = MediaType('image', mimeType);
    request.files.add(await http.MultipartFile.fromPath('sample_file', filePath, contentType: contentType));

    final streamed = await request.send();
    if (streamed.statusCode == 200) {
      return await streamed.stream.toBytes();
    } else {
      final body = await streamed.stream.bytesToString();
      throw Exception('Server ${streamed.statusCode}: $body');
    }
  }
}