import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends ChangeNotifier {
  List orderList = [];
  int mainIndex = 0;

  activeOrderScreen() async {
    orderList = [];
    orderList = await FetchDataFirebase.fetchAllActiveOrders();
    notifyListeners();
  }

  completedOrdersScreen() async {
    orderList = [];
    orderList = await FetchDataFirebase.fetchAllCompletedOrders();
    notifyListeners();
  }

  orderDetailsScreenIndex(int index) {
    mainIndex = index;
  }
}

class OrderScreenDetails extends ChangeNotifier {
  List orderList = [];
  int mainIndex = 0;

  activeOrderScreen({required String orderStatus}) async {
    orderList[mainIndex][orderStatus] =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString();
    notifyListeners();
  }
}
