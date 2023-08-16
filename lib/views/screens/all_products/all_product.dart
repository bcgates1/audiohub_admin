import 'package:audiohub_admin/services/firebase/product_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/all_products/widgets/item_card.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/product/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection(AddProductFirestore.collectionName);
    return Scaffold(
      appBar: const AppbarCom(title: 'ALL PRODUCTS'),
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: kheight * 0.32,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          productId: snapshot.data!.docs[index].id,
                        )));
              },
              child: ItemCard(
                imagepath: snapshot.data!.docs[index]['image'][0],
                discount: snapshot.data!.docs[index]['discount'],
                price: snapshot.data!.docs[index]['price'],
                category: snapshot.data!.docs[index]['category'],
                name: snapshot.data!.docs[index]['name'],
                productId: snapshot.data!.docs[index].id,
                ctx: context,
              ),
            ),
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
