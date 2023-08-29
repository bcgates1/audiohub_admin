import 'package:audiohub_admin/views/screens/orders/widgets/app_bar.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/active_orders.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/completed_order.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: OrderAppbar(),
        body: TabBarView(
          children: [
            ActiveOrders(),
            CompletedOrders(),
          ],
        ),
      ),
    );
  }
}
