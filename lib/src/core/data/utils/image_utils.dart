import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

class ImageUtils {
  static Future<Uint8List?> pickImage(ImageSource source) async {
    try {
      final pickedImage = await _pickImage(source);
      if (kIsWeb) return pickedImage!.readAsBytes();
      final croppedImage = await _cropImage(pickedImage);
      return croppedImage!.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  static Future<XFile?> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: source);
  }

  static Future<CroppedFile?> _cropImage(XFile? pickedImage) async {
    if (pickedImage == null) return null;

    final imageCropper = ImageCropper();
    return await imageCropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 50,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'image-cropper-toolbar-title'.i18n(),
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        ),
      ],
    );
  }
}
