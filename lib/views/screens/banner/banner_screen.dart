import 'package:audiohub_admin/services/firebase/banner.dart';
import 'package:audiohub_admin/utils/fuctions_utils.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/common_widgets/delete_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(
        title: 'BANNER',
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('banners').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('Add banners first'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.04, vertical: kheight * 0.01),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: kwidth * 0.7,
                        height: kheight * 0.2,
                        child: Image.network(
                          snapshot.data!.docs[index]['image'],
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              // Image is fully loaded.
                              return child;
                            } else {
                              // Show a loading indicator while the image is loading.
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => deleteAlert(
                            context: context,
                            onTapfunction: () => Banners.deleteBanner(
                                bannerId: snapshot.data!.docs[index].id, context: context)),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                          elevation: MaterialStatePropertyAll(0),
                          foregroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: const CircleBorder(side: BorderSide()),
        onPressed: () async {
          String? bannerImage = await FuctionUtil.addImage();
          if (bannerImage != null) {
            if (context.mounted) {
              Banners.addBaner(bannerImage: bannerImage, context: context);
            }
          }
        },
        child: Icon(
          Icons.add,
          size: kwidth * 0.1,
        ),
      ),
    );
  }
}
