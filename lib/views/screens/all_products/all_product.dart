import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/services/firebase/product_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/all_products/widgets/item_card.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/product/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.fromBrand = false, this.brandName = ''});
  final String title;
  final bool fromBrand;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection(AddProductFirestore.collectionName);
    return Scaffold(
      appBar: AppbarCom(title: title),
      body: StreamBuilder(
        stream: fromBrand
            ? FetchDataFirebase.fetchBrand(brandName: brandName).snapshots()
            : products.snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Add products first'),
            );
          }

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: kheight * 0.32,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map data = {};

                data = snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              productId: snapshot.data!.docs[index].id,
                            )));
                  },
                  child: ItemCard(
                    imagepath: data['image'][0],
                    discount: data['discount'],
                    price: data['price'],
                    category: data['category'],
                    name: data['name'],
                    productId: snapshot.data!.docs[index].id,
                    ctx: context,
                  ),
                );
              });
        },
      ),
    );
  }
}
