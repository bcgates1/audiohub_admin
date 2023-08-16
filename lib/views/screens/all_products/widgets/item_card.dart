import 'dart:developer';
import 'package:audiohub_admin/controllers/add_product_provider/text_editing_controller.dart';
import 'package:audiohub_admin/models/product_model.dart';
import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/services/firebase/product_services.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    super.key,
    required this.imagepath,
    required this.discount,
    required this.price,
    required this.name,
    required this.category,
    required this.productId,
    required this.ctx,
  });
  final String imagepath;
  final int discount;
  final int price;
  final String name;
  final String category;
  final NumberFormat numberformat = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 0);
  final String productId;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: kwidth * 0.5,
                height: kheight * 0.2,
                child: Image.network(
                  // width: kwidth * 0.5,
                  // height: kheight * 0.2,
                  fit: BoxFit.fitHeight,
                  imagepath,
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   log(loadingProgress!.cumulativeBytesLoaded.toString());

                  //   return Center(
                  //     child: LinearProgressIndicator(
                  //       value: loadingProgress?.cumulativeBytesLoaded.toDouble(),
                  //     ),
                  //   );
                  // },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: googleblackbold.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(category, style: GoogleFonts.inter(color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$discount% OFF',
                            style: GoogleFonts.inter(color: Colors.green, fontSize: 12),
                          ),
                          SizedBox(
                            width: kwidth * 0.08,
                          ),
                          Flexible(
                            child: Text(
                              numberformat.format(price),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text('Delivery in 5 days', style: GoogleFonts.inter(fontSize: 10)),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
              right: -10,
              top: -10,
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text('Delete'),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Edit'),
                  ),
                ],
                onSelected: (value) async {
                  if (value == 0) {
                    //delete product in all product
                    await AddProductFirestore().deleteProductFirestore(
                        productId: productId, context: ctx, productName: name);
                    log('delete product in all product');
                  } else if (value == 1) {
                    //edit product
                    Map actualProduct =
                        await FetchDataFirebase.fetchProductWithId(productId: productId);

                    ProductModel productModel = ProductModel().fromMap(
                      productFromMap: actualProduct,
                    );
                    if (context.mounted) {
                      AddProductTextController productProvider =
                          Provider.of<AddProductTextController>(context, listen: false);
                      productProvider.editProductcontroller(
                        context: context,
                        productModelEdit: productModel,
                        productId: productId,
                      );

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddProduct(
                                isEdit: true,
                              )));
                    }
                  }
                },
              ))
        ],
      ),
    );
  }
}
