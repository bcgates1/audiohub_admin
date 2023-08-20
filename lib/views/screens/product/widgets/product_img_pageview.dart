import 'package:audiohub_admin/controllers/add_product_provider/add_product_image.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPageview extends StatelessWidget {
  const ProductPageview({super.key, required this.images});
  final List images;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductImageProvider>(
      builder: (context, imgIndicator, child) => Column(
        children: [
          SizedBox(
            height: kheight * 0.5,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: (value) => imgIndicator.imageIndicator(value),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    images[index],
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, imgIndicator.showImageindicator),
          )
        ],
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26, shape: BoxShape.circle),
    );
  });
}
