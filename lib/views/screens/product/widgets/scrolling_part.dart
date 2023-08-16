import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/product/widgets/product_delivery_and_details.dart';
import 'package:audiohub_admin/views/screens/product/widgets/product_img_pageview.dart';
import 'package:audiohub_admin/views/screens/product/widgets/product_name_and_discription_part.dart';
import 'package:flutter/material.dart';

class ProductScrollingPart extends StatelessWidget {
  const ProductScrollingPart({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: kheight * 0.02, horizontal: kwidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductPageview(images: snapshot.data['image']),
              ProductNameAndDescription(
                category: snapshot.data['category'],
                description: snapshot.data['description'],
                discount: snapshot.data['discount'],
                name: snapshot.data['name'],
                price: snapshot.data['price'],
              ),
              ProductDeliveryAndDetails(
                snapshot: snapshot,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
