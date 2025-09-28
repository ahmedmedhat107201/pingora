import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'image_compress.dart';

class CustomImagePicker {
  static Future<String?> pickImageFromGallery({
    String? selectedImage,
    ImageSource? imageSource,
  }) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: imageSource ?? ImageSource.gallery,
      );

      if (image != null) {
        // Use the new compression method directly
        final compressedFile = await ImageCompress.compressImage(image.path);

        selectedImage = compressedFile.path;
        return selectedImage;
      } else {
        log('No image selected');
        return null;
      }
    } catch (e) {
      log('Error picking/compressing image: $e');
      return null;
    }
  }

  static bool isNetworkImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return false;
    try {
      final uri = Uri.parse(imagePath);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
