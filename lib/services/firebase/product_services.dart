import 'dart:io';
import 'package:audiohub_admin/models/product_model.dart';
import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/views/screens/common_widgets/alert_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductFirestore {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static String collectionName = 'products';

  addProductFirestore(
      {required ProductModel productModel,
      required BuildContext context,
      String? editProductId}) async {
    loading(context);
    try {
      List<String> urlList = [];
      String imageUrl = '';
      for (int i = 0; i < productModel.images.length; i++) {
        if (!productModel.images[i].contains('https://firebasestorage')) {
          TaskSnapshot snapshot = await _firebaseStorage
              .ref()
              .child('images/products/${productModel.name}image$i')
              .putFile(
                File(productModel.images[i]),
              );
          imageUrl = await snapshot.ref.getDownloadURL();
        } else {
          imageUrl = productModel.images[i];
        }
        urlList.add(imageUrl);
      }

      productModel.images = urlList;

      await _firebase
          .collection(collectionName)
          .doc(editProductId) //if editProductId is not null it updates the product else new product is added
          .set(
            productModel.tomap(),
            SetOptions(merge: true),
          )
          .then(
        (value) {
          // snackbarMessage(message: 'Product added successfully', context: context);
          toastMessage(message: 'Product added successfully');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }

  deleteProductFirestore(
      {required String productId,
      required BuildContext context,
      required String productName}) async {
// Delete the file
    try {
      Map<String, dynamic>? snapshot =
          await FetchDataFirebase.fetchProductWithId(productId: productId);

      // for (int i = 0; i < snapshot!['image'].length; i++) {
      //   await _firebaseStorage.ref().child('images/products/${productName}image$i').delete();
      // }

      await _firebase.collection(collectionName).doc(productId).delete().then(
        (value) {
          snackbarMessage(message: 'Product deleted successfully', context: context);
        },
      );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }
}
