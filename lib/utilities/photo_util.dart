import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PhotoUtil {
  static Future<File> getImage(ImageSource source) async {
    var file = await ImagePicker.pickImage(source: source);
    if (file == null) {
      file = await _retrieveLostData();
    }
    return file;
  }

  static Future<File> _retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return null;
    }
    return response.file;
  }
}
