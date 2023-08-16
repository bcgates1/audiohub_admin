import 'dart:io';
import 'package:audiohub_admin/models/brand_model.dart';
import 'package:audiohub_admin/views/screens/common_widgets/alert_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BrandFirebase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //---------------------brand image storage folder name---------------------------
  static String collectionName = 'brands';

  //----------------------Adding new brands to the collections---------------------

  addToBrandCollection({required BrandModel brandModel, required BuildContext context}) async {
    loading(context);

    try {
      TaskSnapshot snapshot = await _firebaseStorage
          .ref()
          .child('images/brands/${brandModel.brandName}')
          .putFile(File(brandModel.brandImage!));

      String downloadUrl = await snapshot.ref.getDownloadURL();

      await _firebase.collection(collectionName).doc().set(
        {
          'name': brandModel.brandName,
          'image': downloadUrl,
        },
      ).then(
        (value) {
          toastMessage(message: 'Brand added successfully');
          // snackbarMessage(message: 'Brand added successfully', context: context);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }

  brandDelete(
      {required String brandId, required BuildContext context, required String brandName}) async {
    try {
      await _firebaseStorage.ref().child('images/brands/$brandName').delete();
      await _firebase.collection(collectionName).doc(brandId).delete().then(
            (value) => snackbarMessage(message: 'Brand deleted successfully', context: context),
          );
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }
}
