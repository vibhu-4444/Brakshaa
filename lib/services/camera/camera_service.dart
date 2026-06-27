import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final cameraServiceProvider = Provider<CameraService>(
  (ref) => CameraService(ImagePicker()),
);

class CameraService {
  const CameraService(this._picker);

  final ImagePicker _picker;

  Future<XFile?> capturePhoto() {
    return _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 82,
    );
  }

  Future<XFile?> pickFromGallery() {
    return _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 82,
    );
  }

  Future<XFile> compressForUpload(XFile file) async {
    return file;
  }
}
