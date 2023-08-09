import 'dart:io';
import 'package:audiohub_admin/controllers/add_product_provider/add_product.dart';
import 'package:audiohub_admin/controllers/add_product_provider/dropdown_controller.dart';
import 'package:audiohub_admin/controllers/add_product_provider/text_editing.dart';
import 'package:audiohub_admin/services/add_product_fuction/add_product.dart';
import 'package:audiohub_admin/services/firebase/product_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/drop_down_widget.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/text_field.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'ADD PRODUCT'),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => AddProductTextController(),
        child: Consumer<AddProductTextController>(
          builder: (context, addProductTextController, child) => StreamBuilder(
            stream: addProductTextController.brands.snapshots(),
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
              brandadder(
                  snapshot: snapshot,
                  brandlist: addProductTextController.brandlist,
                  brandDocID: addProductTextController.brandDocID);
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
                                addProductTextController.productModel.image =
                                    productImage.imagePath!;
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
                        controller: addProductTextController.nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductAddTextField(
                        hintText: 'Product Description',
                        maxLines: 5,
                        controller: addProductTextController.descriptionController,
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
                          items: addProductTextController.categorylist,
                          value: 'Select Category',
                        ),
                        child: Consumer<DropDownProvider>(
                          builder: (context, DropDownProvider controller, child) {
                            if (controller.value != 'Select Category') {
                              addProductTextController.productModel.category = controller.value;
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
                          items: addProductTextController.brandlist,
                          value: 'Select brand',
                        ),
                        child: Consumer<DropDownProvider>(
                          builder: (context, DropDownProvider controller, child) {
                            if (controller.value != 'Select brand') {
                              addProductTextController.productModel.brand = controller.value;
                            }
                            return DropDownProductAdd(
                              dropDownController: controller,
                            );
                          },
                        ),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => DropDownProvider(
                          items: addProductTextController.typelist,
                          value: 'Select type',
                        ),
                        child: Consumer<DropDownProvider>(
                          builder: (context, DropDownProvider controller, child) {
                            if (controller.value != 'Select type') {
                              addProductTextController.productModel.connectionType =
                                  controller.value;
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
                        controller: addProductTextController.priceController,
                        inputTypeNum: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductAddTextField(
                        hintText: 'Product Discount',
                        controller: addProductTextController.discountController,
                        inputTypeNum: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductAddTextField(
                        hintText: 'Product Quantity',
                        controller: addProductTextController.quantityController,
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
                          addProductTextController.productModel.name =
                              addProductTextController.nameController.text.trim();
                          addProductTextController.productModel.description =
                              addProductTextController.descriptionController.text.trim();
                          addProductTextController.productModel.stringprice =
                              addProductTextController.priceController.text.trim();
                          addProductTextController.productModel.stringdiscount =
                              addProductTextController.discountController.text.trim();
                          addProductTextController.productModel.stringquantity =
                              addProductTextController.quantityController.text.trim();
                          if (addProduct(
                              context: context, product: addProductTextController.productModel)) {
                            AddProductFirestore().addProductFirestore(
                                productModel: addProductTextController.productModel,
                                context: context);
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
        ),
      ),
    );
  }
}
