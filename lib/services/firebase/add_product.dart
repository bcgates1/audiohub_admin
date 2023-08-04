import 'dart:io';

import 'package:audiohub_admin/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductFirestore {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static String collectionName = 'products';

  addProductFirestore({required ProductModel productModel, required BuildContext context}) async {
    try {
      TaskSnapshot snapshot = await _firebaseStorage
          .ref()
          .child('images/products/${productModel.name}image')
          .putFile(File(productModel.image));
      String imageUrl = await snapshot.ref.getDownloadURL();
      await _firebase.collection(collectionName).doc().set({
        'name': productModel.name,
        'description': productModel.description,
        'image': imageUrl,
        'category': productModel.category,
        'brand': productModel.brand,
        'connectionType': productModel.connectionType,
        'price': productModel.price,
        'discount': productModel.discount,
        'quantity': productModel.quantity
      }).then((value) {
        alertshower(message: 'Product added successfully', context: context, isSuccess: true);
      });
    } on FirebaseException catch (e) {
      alertshower(message: e.message!, context: context);
    }
  }

  alertshower({required String message, required BuildContext context, bool isSuccess = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
