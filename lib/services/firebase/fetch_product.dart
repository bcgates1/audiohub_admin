import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDataFirebase {
  static String collecionName = 'products';

  static Future<Map<String, dynamic>> fetchProductWithId(
      {required String productId, String collecionName = 'products'}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(collecionName).doc(productId).get();

    return snapshot.data()!;
  }

  static Query<Map<String, dynamic>> fetchBrand({required String brandName}) {
    Query<Map<String, dynamic>> snapshot =
        FirebaseFirestore.instance.collection(collecionName).where('brand', isEqualTo: brandName);
    return snapshot;
  }

  static Future<List> fetchAllActiveOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> data = await firestore.collection('orders').get();
    if (data.docs.isNotEmpty) {
      List orderLists = data.docs[0]['orderLists'];
      List activeOrders = [];
      for (var orderData in orderLists) {
        if (orderData['deliverydate'] == '') {
          activeOrders.add(orderData);
        }
      }
      return activeOrders;
    }
    return [];
  }

  static Future<List> fetchAllCompletedOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> data = await firestore.collection('orders').get();
    if (data.docs.isNotEmpty) {
      List orderLists = data.docs[0]['orderLists'];
      List completedOrders = [];
      for (var orderData in orderLists) {
        if (orderData['deliverydate'] != '') {
          completedOrders.add(orderData);
        }
      }
      log(completedOrders.toString());
      return completedOrders;
    }
    return [];
  }
}
