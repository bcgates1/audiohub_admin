import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/orders/change_status.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/product_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarCom(
          title: 'Order Status',
        ),
        body: const Column(
          children: [
            OrderScreenProductDetails(
              order: false,
            ),
            Flexible(
              child: RotatedBox(
                quarterTurns: 1,
                child: LinearProgressIndicator(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              changeStatus(context: context);
            },
            child: const Icon(Icons.add)));
  }
}
