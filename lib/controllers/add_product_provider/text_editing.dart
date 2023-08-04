import 'package:audiohub_admin/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductTextController extends ChangeNotifier {
  final CollectionReference brands = FirebaseFirestore.instance.collection('brands');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final Map<String, String> brandDocID = {};

  final List<String> brandlist = [];
  final List<String> typelist = ['Wireless', 'Wired'];

  final List<String> categorylist = ['Headphone', 'Neckband', 'TWS'];

  final ProductModel productModel = ProductModel();
}
