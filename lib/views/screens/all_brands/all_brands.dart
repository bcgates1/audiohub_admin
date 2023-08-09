import 'package:audiohub_admin/services/firebase/brand_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/all_brands/widgets/brand_card.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});
  static String brandDocID = '';

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
                  // brandDocID = snapshot.data!.docs[index].id;
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const ProductDetails(),
                  // ));
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

// class BrandItems extends StatelessWidget {
//   const BrandItems({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: kheight * 0.02),
//                 child: SizedBox(
//                   width: kwidth * 0.30,
//                   height: kheight * 0.15,
//                   child: Image.network(
//                     snapshot.data!.docs[index]['image'],
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: kheight * 0.01,
//               ),
//               Text(
//                 '${snapshot.data!.docs[index]['name']}',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



