import 'package:audiohub_admin/services/firebase/add_brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

brandDelete({required String brandId}) async {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  await firebase.collection(BrandFirebase.collectionName).doc(brandId).delete();

  // log(docRef.toString());

  // alertshower(message: 'Brand deleted successfully', context: context, isSuccess: true);
}
