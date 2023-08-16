import 'package:audiohub_admin/controllers/add_product_provider/add_product_image.dart';
import 'package:audiohub_admin/models/product_model.dart';
import 'package:audiohub_admin/services/add_product_fuction/add_product.dart';
import 'package:audiohub_admin/services/firebase/product_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  ProductModel productModel = ProductModel();

  addproductcontroller({
    required BuildContext context,
    bool isedit = false,
  }) {
    productModel.name = nameController.text.trim();
    productModel.description = descriptionController.text.trim();
    productModel.stringprice = priceController.text.trim();
    productModel.stringdiscount = discountController.text.trim();
    productModel.stringquantity = quantityController.text.trim();
    if (addProduct(context: context, product: productModel)) {
      if (isedit) {
        AddProductFirestore().addProductFirestore(
            productModel: productModel, context: context, editProductId: editProductId);
      } else {
        AddProductFirestore().addProductFirestore(productModel: productModel, context: context);
      }
    }
  }

  //for editing
  String catagoryEdit = '';
  String brandEdit = '';
  String typeEdit = '';
  String editProductId = '';

  editProductcontroller(
      {required BuildContext context,
      required ProductModel productModelEdit,
      required String productId}) {
    productModel = productModelEdit;
    ProductImageProvider productImageProvider =
        Provider.of<ProductImageProvider>(context, listen: false);
    productImageProvider.editImage(productImageList: productModelEdit.images);

    nameController.text = productModelEdit.name;
    descriptionController.text = productModelEdit.description;
    priceController.text = productModelEdit.price.toString();
    discountController.text = productModelEdit.discount.toString();
    quantityController.text = productModelEdit.quantity.toString();
    catagoryEdit = productModelEdit.category;
    brandEdit = productModelEdit.brand;
    typeEdit = productModelEdit.connectionType;
    editProductId = productId;
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    discountController.text = '';
    quantityController.text = '';
    productModel = ProductModel();

    notifyListeners();
  }
}
