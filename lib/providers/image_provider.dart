import 'package:flutte_scanner_empty/data/models/image_model.dart';
import 'package:flutter/material.dart';

class ImageProvider extends ChangeNotifier {
  ImageModel _image = ImageModel();
  ImageModel get image => _image;
  set image(ImageModel image) {
    _image = image;
    notifyListeners();
  }
}