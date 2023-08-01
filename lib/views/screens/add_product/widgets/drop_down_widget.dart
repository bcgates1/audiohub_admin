import 'package:audiohub_admin/controllers/add_product_provider/dropdown_controller.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';

class DropDownProductAdd extends StatelessWidget {
  const DropDownProductAdd({super.key, required this.dropDownController});
  final DropDownProvider dropDownController;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // value: dropDownController.value,
      isExpanded: true,
      style: googleblack,
      icon: const Icon(Icons.arrow_drop_down),
      // iconSize: kwidth * 0.08,
      hint: Text(dropDownController.value),
      items: dropDownController.items.map(
        (String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        },
      ).toList(),
      onChanged: (value) {
        String selectedvalue = value!;
        dropDownController.selectItem(selectedvalue);
      },
    );
  }
}
