import 'dart:developer';
import 'dart:io';
import 'package:audiohub_admin/controllers/add_product_provider/add_product.dart';
import 'package:audiohub_admin/controllers/add_product_provider/dropdown_controller.dart';
import 'package:audiohub_admin/models/product_model.dart';
import 'package:audiohub_admin/services/add_product_fuction/add_product.dart';
import 'package:audiohub_admin/services/firebase/add_product.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/drop_down_widget.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/text_field.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final CollectionReference brands = FirebaseFirestore.instance.collection('brands');

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _discountController = TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  final Map<String, String> brandDocID = {};

  final List<String> brandlist = [];
  final List<String> typelist = ['Wireless', 'Wired'];

  final List<String> categorylist = ['Headphone', 'Neckband', 'TWS'];

  final ProductModel _productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'ADD PRODUCT'),
      body: StreamBuilder(
        stream: brands.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.docs.isEmpty) {
            return const Center(
              child: Text('Add brands first'),
            );
          }
          brandadder(snapshot: snapshot, brandlist: brandlist, brandDocID: brandDocID);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  ChangeNotifierProvider(
                    create: (BuildContext context) => ProductImageProvider(),
                    child: Consumer<ProductImageProvider>(
                      builder: (context, productImage, child) => InkWell(
                        onTap: () async {
                          await productImage.addImage();
                          if (productImage.imagePath != null) {
                            _productModel.image = productImage.imagePath!;
                          }
                        },
                        child: Container(
                          height: kwidth * 0.5,
                          width: kheight * 0.6,
                          color: Colors.grey,
                          child: productImage.imagePath == null
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('ADD IMAGE', style: googlewhitebold),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              : Image.file(
                                  File(productImage.imagePath!),
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductAddTextField(
                    hintText: 'Product Name',
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductAddTextField(
                    hintText: 'Product Description',
                    maxLines: 5,
                    controller: _descriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Product Category',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => DropDownProvider(
                      items: categorylist,
                      value: 'Select Category',
                    ),
                    child: Consumer<DropDownProvider>(
                      builder: (context, DropDownProvider controller, child) {
                        if (controller.value != 'Select Category') {
                          _productModel.category = controller.value;
                        }
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Product Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20),
                  ChangeNotifierProvider(
                    create: (context) => DropDownProvider(
                      items: brandlist,
                      value: 'Select brand',
                    ),
                    child: Consumer<DropDownProvider>(
                      builder: (context, DropDownProvider controller, child) {
                        if (controller.value != 'Select brand') {
                          _productModel.brand = controller.value;
                        }
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      },
                    ),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => DropDownProvider(
                      items: typelist,
                      value: 'Select type',
                    ),
                    child: Consumer<DropDownProvider>(
                      builder: (context, DropDownProvider controller, child) {
                        if (controller.value != 'Select type') {
                          _productModel.connectionType = controller.value;
                        }
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductAddTextField(
                    hintText: 'Product Price',
                    controller: _priceController,
                    inputTypeNum: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductAddTextField(
                    hintText: 'Product Discount',
                    controller: _discountController,
                    inputTypeNum: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductAddTextField(
                    hintText: 'Product Quantity',
                    controller: _quantityController,
                    inputTypeNum: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _productModel.name = _nameController.text.trim();
                      _productModel.description = _descriptionController.text.trim();
                      _productModel.stringprice = _priceController.text.trim();
                      _productModel.stringdiscount = _discountController.text.trim();
                      _productModel.stringquantity = _quantityController.text.trim();
                      if (addProduct(context: context, product: _productModel)) {
                        AddProductFirestore()
                            .addProductFirestore(productModel: _productModel, context: context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        'ADD PRODUCT',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
