import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageProvider extends ChangeNotifier {
  String? imagePath;
  

  addImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
    notifyListeners();
  }
}
