import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BrandProvider extends ChangeNotifier {
  String? imagePath;
  final TextEditingController _brandNameController = TextEditingController();
  TextEditingController get brandNameController => _brandNameController;

  addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
    notifyListeners();
  }
}
