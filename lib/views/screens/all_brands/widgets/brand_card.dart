import 'package:audiohub_admin/services/firebase/brand_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/delete_alert.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.imagepath,
    required this.name,
    required this.brandId,
    required this.ctx,
  });
  final String imagepath;
  final String name;
  final String brandId;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.grey,
          // ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
            ),
          ]),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Image.network(
                  width: kwidth * 0.485,
                  height: kheight * 0.14,
                  fit: BoxFit.fill,
                  imagepath,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kheight * 0.02),
                child: Text(
                  name,
                  style: googleblackbold.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Positioned(
              right: -10,
              bottom: 0,
              child: IconButton(
                  onPressed: () {
                    //delete product in all product
                    deleteAlert(
                      context: context,
                      onTapfunction: () {
                        BrandFirebase()
                            .brandDelete(brandId: brandId, context: ctx, brandName: name);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.black,
                  )))
        ],
      ),
    );
  }
}
