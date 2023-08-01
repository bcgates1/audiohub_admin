import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';

class ProductAddTextField extends StatelessWidget {
  const ProductAddTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    required this.controller,
    this.inputTypeNum = false,
  });
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final bool inputTypeNum;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputTypeNum ? TextInputType.number : TextInputType.text,
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
