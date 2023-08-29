import 'package:image_picker/image_picker.dart';

class FuctionUtil {
  static addImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return;
  }
}
