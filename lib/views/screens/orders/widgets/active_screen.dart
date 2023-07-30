import 'package:audiohub_admin/views/screens/orders/widgets/product_details_tile.dart';
import 'package:flutter/material.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OrderScreenProductDetails(track: true),
        ),
      ],
    );
  }
}
