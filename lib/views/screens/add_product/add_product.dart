import 'package:audiohub_admin/controllers/add_product_provider/add_product_image.dart';
import 'package:audiohub_admin/controllers/add_product_provider/dropdown_controller.dart';
import 'package:audiohub_admin/controllers/add_product_provider/text_editing_controller.dart';
import 'package:audiohub_admin/services/add_product_validation/add_product.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/drop_down_widget.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/image_shower.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/text_field.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({
    super.key,
    this.isEdit = false,
  });
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final addProductTextController =
            Provider.of<AddProductTextController>(context, listen: false);
        final productImageProvider = Provider.of<ProductImageProvider>(context, listen: false);

        addProductTextController.resetValues();
        productImageProvider.resetValues();

        return true;
      },
      child: Scaffold(
        appBar: const AppbarCom(title: 'ADD PRODUCT'),
        body: Consumer<AddProductTextController>(
          builder: (context, addProductTextController, child) => StreamBuilder(
            stream: addProductTextController.brands.snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Add brands first'),
                );
              }
              //to add brand to list
              brandadder(
                snapshot: snapshot,
                brandlist: addProductTextController.brandlist,
                brandDocID: addProductTextController.brandDocID,
              );
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      ProductImageWidget(
                        addProductTextController: addProductTextController,
                      ),
                      SizedBox(
                        height: kheight * 0.01,
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
                          value: isEdit ? addProductTextController.catagoryEdit : 'Select Category',
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
                          value: isEdit ? addProductTextController.brandEdit : 'Select brand',
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
                          value: isEdit ? addProductTextController.typeEdit : 'Select type',
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
                          FocusScope.of(context).unfocus();
                          if (isEdit) {
                            addProductTextController.addproductcontroller(
                                context: context, isedit: true);
                          } else {
                            addProductTextController.addproductcontroller(context: context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kheight * 0.01, horizontal: kwidth * 0.01),
                          child: Text(
                            isEdit ? 'UPDATE' : 'ADD PRODUCT',
                            style: googlewhitebold.copyWith(fontSize: 20),
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
