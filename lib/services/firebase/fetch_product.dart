import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDataFirebase {
  static String collecionName = 'products';

  static Future<Map<String, dynamic>> fetchProductWithId({required String productId}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(collecionName).doc(productId).get();

    return snapshot.data()!;
  }
}
