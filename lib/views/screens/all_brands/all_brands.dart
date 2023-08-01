import 'package:audiohub_admin/services/firebase/add_brand.dart';
import 'package:audiohub_admin/services/firebase/delete_brand.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});
  static String brandDocID = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference brands =
        FirebaseFirestore.instance.collection(BrandFirebase.collectionName);

    return Scaffold(
      appBar: const AppbarCom(title: 'ALL BRAND'),
      body: StreamBuilder(
        stream: brands.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: kheight * 0.25,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => Stack(
              children: [
                InkWell(
                  onTap: () {
                    // brandDocID = snapshot.data!.docs[index].id;
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const ProductDetails(),
                    // ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: kheight * 0.02),
                              child: SizedBox(
                                width: kwidth * 0.30,
                                height: kheight * 0.15,
                                child: Image.network(
                                  snapshot.data!.docs[index]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: kheight * 0.01,
                            ),
                            Text(
                              '${snapshot.data!.docs[index]['name']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        PopupMenuButton(
                          color: Colors.black,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 0,
                              child: Row(
                                children: [
                                  const Icon(Icons.delete),
                                  Text('Delete', style: GoogleFonts.inter(color: Colors.white))
                                ],
                              ),
                            )
                          ],
                          onSelected: (value) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Do you want to Delete'),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          brandDelete(brandId: snapshot.data!.docs[index].id);
                                        },
                                        child: const Text('Yes')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
          );
        },
      ),
    );
  }
}
