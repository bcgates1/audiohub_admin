import 'package:flutter/material.dart';

class DropDownProvider extends ChangeNotifier {
  
  DropDownProvider({required this.items, required this.value});
  List<String> items;
  String value;

  selectItem(String selectedValue) {
    value = selectedValue;

    notifyListeners();
  }
}
