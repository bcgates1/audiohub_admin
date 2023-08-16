import 'dart:io';

import 'package:audiohub_admin/controllers/add_product_provider/add_product_image.dart';
import 'package:audiohub_admin/controllers/add_product_provider/text_editing_controller.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.addProductTextController,
  });
  final AddProductTextController addProductTextController;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductImageProvider>(
      builder: (context, imagectrl, child) => Column(
        children: [
          InkWell(
            onTap: () async {
              await imagectrl.addImage();
              if (imagectrl.imageList != null) {
                addProductTextController.productModel.images = imagectrl.imageList!;
              }
            },
            child: Stack(children: [
              Container(
                height: kwidth * 0.5,
                width: kheight * 0.6,
                color: imagectrl.imageList != null ? Colors.white : Colors.grey,
                child: Center(
                  child: imagectrl.imageList == null
                      ? Row(
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
                        )
                      : imagectrl.imagePath!.contains('https://firebasestorage')
                          ? Image.network(
                              imagectrl.imagePath!,
                              fit: BoxFit.fitHeight,
                            )
                          : Image.file(
                              File(imagectrl.imagePath!),
                              fit: BoxFit.fitHeight,
                            ),
                ),
              ),
              if (imagectrl.imageList != null)
                Positioned(
                  right: -6,
                  child: InkWell(
                    onTap: () => imagectrl.deleteImage(),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
            ]),
          ),
          if (imagectrl.imageList != null)
            Padding(
              padding: EdgeInsets.only(top: kheight * 0.006),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: kheight * 0.08,
                      width: kwidth * 0.7,
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: imagectrl.imageList!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: kwidth * 0.01),
                            child: InkWell(
                              onTap: () {
                                imagectrl.updateImage(index);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    imagectrl.imageList![index]!.contains('https://firebasestorage')
                                        ? Image.network(
                                            imagectrl.imageList![index],
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Image.file(
                                            File(imagectrl.imageList![index]),
                                            fit: BoxFit.contain,
                                          ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kheight * 0.08,
                    width: kwidth * 0.17,
                    child: Ink(
                      // padding: EdgeInsets.zero,
                      decoration: const ShapeDecoration(
                        color: Colors.black,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        // padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add_a_photo_rounded),
                        color: Colors.white,
                        onPressed: () async {
                          await imagectrl.addImage();
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
