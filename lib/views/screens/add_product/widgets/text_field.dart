import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';

class ProductAddTextField extends StatelessWidget {
  const ProductAddTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
  });
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: googleblack,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}