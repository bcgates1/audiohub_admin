import 'dart:io';
import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/views/screens/common_widgets/alert_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Banners {
  static final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static addBaner({required BuildContext context, required String bannerImage}) async {
    try {
      TaskSnapshot snapshot = await _firebaseStorage
          .ref()
          .child('images/banners/$bannerImage')
          .putFile(File(bannerImage));
      String imageUrl = await snapshot.ref.getDownloadURL();

      await _firebase.collection('banners').doc().set({
        'image': imageUrl,
      }).then((value) {
        toastMessage(message: 'Banner added successfully');
      });
    } on FirebaseException catch (e) {
      alertshower(message: e.toString(), context: context);
    }
  }

  static deleteBanner({required String bannerId, required BuildContext context}) async {
    try {
      Map<String, dynamic>? snapshot =
          await FetchDataFirebase.fetchProductWithId(productId: bannerId, collecionName: 'banners');

      String url = snapshot['image'];

      Uri uri = Uri.parse(url);

      // Gets the last segment of the path
      String imagePath = uri.pathSegments.last;

      // Remove any URL encoding (e.g., %20 becomes space)
      imagePath = Uri.decodeComponent(imagePath);

      await _firebaseStorage.ref().child(imagePath).delete();

      await _firebase.collection('banners').doc(bannerId).delete().then((value) {
        toastMessage(message: 'Banner deleted successfully');
      });
    } on FirebaseException catch (e) {
      alertshower(message: e.toString(), context: context);
    }
  }
}
