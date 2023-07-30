import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'Order details'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imgpath),
            Text('Order no : 000000000', style: googleblackbold),
            Text('Name :Sony 1000XM5 ', style: googleblackbold),
            Text('Price : ₹ 28990', style: googleblackbold),
            Text('Quantity : 1', style: googleblackbold),
            Text('Shipping Address :', style: googleblackbold),
            Text('housename, place, post, landmark, pincode', style: googleblackbold),
            Text('phone : XXXXXXXXXXX', style: googleblackbold),
          ],
        ),
      ),
    );
  }
}
