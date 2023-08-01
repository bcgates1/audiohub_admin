import 'package:audiohub_admin/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

brandadder(
    {required AsyncSnapshot snapshot,
    required List<String> brandlist,
    required Map<String, String> brandDocID}) {
  for (QueryDocumentSnapshot<Object?> brand in snapshot.data!.docs) {
    if (!brandlist.contains(brand['name'])) {
      brandlist.add(brand['name']);
      brandDocID[brand['name']] = brand.id;
    }
  }
}

bool addProduct({required BuildContext context, required ProductModel product}) {
  alertshower({required String message}) {
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
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  product.price = int.tryParse(product.stringprice);
  product.discount = int.tryParse(product.stringdiscount);
  if (product.image.isEmpty) {
    alertshower(
      message: 'Must contain atleast 1 image',
    );
    return false;
  } else if (product.name == '') {
    alertshower(message: 'Name is invalid');
    return false;
  } else if (product.description == '') {
    alertshower(message: 'Description is required');
    return false;
  } else if (product.category == '') {
    alertshower(message: 'Catogory is not selected');
    return false;
  } else if (product.brand == '') {
    alertshower(message: 'Brand not selected');
    return false;
  } else if (product.connectionType == '') {
    alertshower(message: 'Type not selected');
    return false;
  } else if (product.price == null || product.price! < 0) {
    alertshower(message: 'Invalid price');
    return false;
  } else if (product.discount == null ||
      (product.discount ?? -1) < 0 ||
      (product.discount ?? -1) > 100) {
    alertshower(message: 'Invalid discount\n(discount should be in between 0 to 100)');
    return false;
  }
  return true;
}
