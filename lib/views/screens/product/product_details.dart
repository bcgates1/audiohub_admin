import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/product/widgets/scrolling_part.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppbarCom(title: 'Product'),
        body: FutureBuilder(
            future: FetchDataFirebase.fetchProductWithId(productId: productId),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: [
                      ProductScrollingPart(
                        snapshot: snapshot,
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
