import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageProvider extends ChangeNotifier {
  List? imageList;
  String? imagePath;
  int showImageindicator = 0;

  addImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageList ??= [];
      imageList?.add(pickedFile.path);
      imagePath = pickedFile.path;
    }
    notifyListeners();
  }

  updateImage(int index) {
    imagePath = imageList?[index];
    notifyListeners();
  }

  deleteImage() {
    int index = imageList!.indexOf(imagePath!);
    imageList!.removeAt(index);
    if (imageList!.isNotEmpty) {
      if (index != 0) {
        imagePath = imageList![index - 1];
      } else {
        imagePath = imageList![0];
      }
    } else {
      imageList = null;
    }
    notifyListeners();
  }

  editImage({required List productImageList}) {
    if (productImageList.isNotEmpty) {
      imageList = productImageList;
      imagePath = imageList![0];
    }
  }

  resetValues() {
    imageList = null;
    imagePath = null;
  }

  imageIndicator(int index) {
    showImageindicator = index;
    notifyListeners();
  }
}
