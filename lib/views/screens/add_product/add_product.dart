import 'dart:developer';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/widgets/text_field.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'ADD BRAND'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  log('add image');
                },
                child: Container(
                  height: kwidth * 0.5,
                  width: kheight * 0.6,
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ProductAddTextField(hintText: 'Product Name'),
              const SizedBox(
                height: 20,
              ),
              const ProductAddTextField(hintText: 'Product Description', maxLines: 5),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Product Category',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text('Select item'),
                    ),
                    body: const ListTile(
                        // title: Text(''),
                        ),
                    isExpanded: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Product Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text('Select Brand'),
                    ),
                    body: const ListTile(
                        // title: Text(''),
                        ),
                    isExpanded: false,
                  ),
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text('Select Type'),
                    ),
                    body: const ListTile(
                        // title: Text(''),
                        ),
                    isExpanded: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ProductAddTextField(hintText: 'Product Price'),
              const SizedBox(
                height: 20,
              ),
              const ProductAddTextField(hintText: 'Product Discount'),
              const SizedBox(
                height: 20,
              ),
              const ProductAddTextField(hintText: 'Product Quantity'),
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
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'ADD PRODUCT',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
