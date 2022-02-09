import 'package:image_picker/image_picker.dart';

class PhotoUtil {
  static Future<PickedFile> getImage(ImageSource source) async {
    var file = await ImagePicker().getImage(source: source);
    if (file == null) {
      file = await _retrieveLostData();
    }
    return file;
  }

  static Future<PickedFile> _retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response == null) {
      return null;
    }
    return response.file;
  }
}
