import 'package:image_picker/image_picker.dart';

/// Wraps [ImagePicker]. On Android 13+ `pickImage(source: gallery)` uses the
/// system Photo Picker (no runtime permission needed). Camera triggers the OS
/// permission prompt at point-of-use.
class ImagePickerService {
  ImagePickerService([ImagePicker? picker]) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;

  /// Returns the temp file path, or null if the user cancelled.
  Future<String?> pickFromCamera() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 85,
    );
    return file?.path;
  }

  Future<String?> pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    return file?.path;
  }
}
