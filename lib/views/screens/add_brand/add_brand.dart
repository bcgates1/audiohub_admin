import 'dart:io';
import 'package:audiohub_admin/controllers/add_brand_provider/add_brand.dart';
import 'package:audiohub_admin/models/brand_model.dart';
import 'package:audiohub_admin/services/firebase/add_brand.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_brand/widgets/alert_widget.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBrand extends StatelessWidget {
  const AddBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: const AppbarCom(title: 'ADD BRAND'),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ChangeNotifierProvider(
              create: (BuildContext context) {
                return BrandProvider();
              },
              child: Consumer<BrandProvider>(
                builder: (context, brandimageProvider, child) => SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          brandimageProvider.addImage();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: brandimageProvider.imagePath == null
                            ? Container(
                                height: kwidth * 0.5,
                                width: kheight * 0.4,
                                color: Colors.grey,
                                child: Center(
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
                                ),
                              )
                            : Image.file(File(brandimageProvider.imagePath!), fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: brandimageProvider.brandNameController,
                        decoration: InputDecoration(
                          labelText: 'Brand Name',
                          labelStyle: googleblack,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
                          //---------------create new function------------------------
                          if (brandimageProvider.imagePath != null &&
                              brandimageProvider.brandNameController.text.trim() != '' &&
                              nameRegExp
                                  .hasMatch(brandimageProvider.brandNameController.text.trim())) {
                            BrandModel branddata = BrandModel(
                                brandImage: brandimageProvider.imagePath!,
                                brandName: brandimageProvider.brandNameController.text.trim());
                            await BrandFirebase()
                                .addToBrandCollection(brandModel: branddata, context: context);
                          } else {
                            validationAlert(context);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ADD BRAND',
                              style: googlewhitebold,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          // _brandNameController.text = '';
          return true;
        });
  }
}
