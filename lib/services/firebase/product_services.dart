import 'dart:io';
import 'package:audiohub_admin/models/product_model.dart';
import 'package:audiohub_admin/views/screens/common_widgets/alert_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductFirestore {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static String collectionName = 'products';

  addProductFirestore({required ProductModel productModel, required BuildContext context}) async {
    loading(context);
    try {
      TaskSnapshot snapshot =
          await _firebaseStorage.ref().child('images/products/${productModel.name}image').putFile(
                File(productModel.image),
              );
      String imageUrl = await snapshot.ref.getDownloadURL();
      productModel.image = imageUrl;

      await _firebase.collection(collectionName).doc().set(productModel.tomap()).then(
        (value) {
          snackbarMessage(message: 'Product added successfully', context: context);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }

  deleteProductFirestore(
      {required String productID,
      required BuildContext context,
      required String productName}) async {
// Delete the file
    try {
      _firebaseStorage.ref().child('images/products/${productName}image').delete();

      await _firebase.collection(collectionName).doc(productID).delete().then(
        (value) {
          snackbarMessage(message: 'Product deleted successfully', context: context);
        },
      );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }
}
