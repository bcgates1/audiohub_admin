import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/common_widgets/item_card.dart';
import 'package:audiohub_admin/views/screens/product/product_details.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'ALL PRODUCTS'),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: kheight * 0.32,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const ProductDetails()));
          },
          child: ItemCard(imagepath: imgpath, discount: 70, price: 28990),
        ),
        padding: const EdgeInsets.all(8),
        itemCount: 3,
      ),
    );
  }
}
