import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagesCropper {
  static Future<File?> cropImage(XFile file) async {
    final File? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Palette.appBarColor,
        toolbarTitle: "Crop Image",
        statusBarColor: Colors.green.shade700,
        backgroundColor: Colors.white,
      ),
    );
    return croppedImage;
  }
}
