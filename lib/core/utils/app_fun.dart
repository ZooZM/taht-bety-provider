import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppFun {
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static Future<String> imageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    return base64Image;
  }

  static Future<String> getStaticImagePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();

    return '${directory.path}/$fileName';
  }

  static Future<File> base64ToFile(String base64String, String fileName) async {
    // Remove the data:image/jpeg;base64, prefix if present
    final regex = RegExp(r'data:image/[^;]+;base64,');
    String cleanedBase64 = base64String.replaceFirst(regex, '');

    // Decode the base64 string
    final bytes = base64Decode(cleanedBase64);
    final filePath = await getStaticImagePath(fileName);
    // Write the bytes to a file
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<File> pickImage({required ImageSource imageSource}) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: imageSource,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      return file;
    } else {
      throw Exception('No image selected');
    }
  }
}
