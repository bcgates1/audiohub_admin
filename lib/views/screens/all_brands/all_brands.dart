import 'package:audiohub_admin/services/firebase/brand_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/all_brands/widgets/brand_card.dart';
import 'package:audiohub_admin/views/screens/all_products/all_product.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference brands =
        FirebaseFirestore.instance.collection(BrandFirebase.collectionName);

    return Scaffold(
      appBar: const AppbarCom(title: 'ALL BRAND'),
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      body: StreamBuilder(
        stream: brands.snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(kwidth * 0.02),
            child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: kheight * 0.22,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllProducts(
                      title: snapshot.data!.docs[index]['name'],
                      brandName: snapshot.data!.docs[index]['name'],
                      fromBrand: true,
                    ),
                  ));
                },
                child: BrandCard(
                  imagepath: snapshot.data!.docs[index]['image'],
                  name: snapshot.data!.docs[index]['name'],
                  brandId: snapshot.data!.docs[index].id,
                  ctx: context,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
