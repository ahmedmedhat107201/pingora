import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageCompress {
  static Future<File> compressImage(String filePath) async {
    try {
      final originalFile = File(filePath);
      final originalBytes = await originalFile.readAsBytes();

      // If the image is already under 1MB, return as is
      if (originalBytes.lengthInBytes < 1024 * 1024) {
        log(
          'Image already under 1MB: ${(originalBytes.lengthInBytes / 1024).toStringAsFixed(2)}KB',
        );
        return originalFile;
      }

      log(
        'Original image size: ${(originalBytes.lengthInBytes / (1024 * 1024)).toStringAsFixed(2)}MB, compressing...',
      );

      // Create temporary directory for compressed files
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final targetPath = path.join(tempDir.path, 'compressed_$timestamp.jpg');

      // Progressive compression settings
      int quality = 70; // Start with good quality
      int maxWidth = 1000;
      int maxHeight = 1000;

      File? compressedFile;

      // Try compression with different settings until under 1MB
      for (int attempt = 0; attempt < 5; attempt++) {
        try {
          final result = await FlutterImageCompress.compressAndGetFile(
            originalFile.path,
            targetPath.replaceAll('.jpg', '_$attempt.jpg'),
            quality: quality,
            minWidth: maxWidth,
            minHeight: maxHeight,
            format: CompressFormat.jpeg,
          );

          if (result != null) {
            compressedFile = File(result.path);
            final fileSizeInBytes = await compressedFile.length();
            final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

            log(
              'Compression attempt ${attempt + 1}: ${fileSizeInMB.toStringAsFixed(2)}MB',
            );

            // If file is under 1MB, we're done
            if (fileSizeInBytes < 1024 * 1024) {
              log(
                'Image compressed successfully to ${fileSizeInMB.toStringAsFixed(2)}MB',
              );
              return compressedFile;
            }

            // More aggressive settings for next attempt
            quality = (quality * 0.75).round(); // Reduce quality by 25%
            maxWidth = (maxWidth * 0.85).round(); // Reduce dimensions by 15%
            maxHeight = (maxHeight * 0.85).round();

            // Set minimum limits
            if (quality < 20) quality = 20;
            if (maxWidth < 300) maxWidth = 300;
            if (maxHeight < 300) maxHeight = 300;
          }
        } catch (e) {
          log('Error in compression attempt ${attempt + 1}: $e');
          continue;
        }
      }

      // If we still couldn't compress enough, return the best attempt or original
      if (compressedFile != null) {
        final finalSize = await compressedFile.length();
        log(
          'Final compressed size: ${(finalSize / (1024 * 1024)).toStringAsFixed(2)}MB',
        );
        return compressedFile;
      }

      log('Could not compress effectively, returning original');
      return originalFile;
    } catch (e) {
      log('Error compressing image: $e');
      return File(filePath); // Return original if compression fails
    }
  }

  // Helper method to get compressed file path for API uploads
  // Returns the path of compressed file that can be used with MultipartFile.fromFile()
  Future<String> getCompressedFilePath(String filePath) async {
    try {
      final compressedFile = await compressImage(filePath);
      return compressedFile.path;
    } catch (e) {
      log('Error getting compressed file path: $e');
      return filePath; // Return original path if compression fails
    }
  }

  // Helper method to get MIME type from file extension
  static String getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      default:
        return 'image/jpeg';
    }
  }
}
