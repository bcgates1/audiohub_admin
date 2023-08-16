import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';

class ProductPageview extends StatelessWidget {
  const ProductPageview({super.key, required this.images});
  final List images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kheight * 0.5,
      width: double.infinity,
      child: PageView.builder(
        itemBuilder: (context, index) => SizedBox(
          width: double.infinity,
          child: Image.network(
            images[index],
            fit: BoxFit.fitHeight,
          ),
        ),
        itemCount: images.length,
      ),
    );
  }
}
