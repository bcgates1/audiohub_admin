import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/orders/order_details.dart';
import 'package:audiohub_admin/views/screens/orders/order_status.dart';
import 'package:flutter/material.dart';

class OrderScreenProductDetails extends StatelessWidget {
  const OrderScreenProductDetails({
    super.key,
    this.track = false,
    this.order = true,
  });
  final bool track;
  final bool order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: kheight * 0.2,
              width: kwidth * 0.2,
              child: Image.network(
                imgpath,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Text('Sony 1000XM5', style: googleblackbold),
                const Text('Order ID = 1234567890'),
                const Text('Quantity = 1'),
                const Text('Price = 28,990'),
              ],
            ),
            TextButton(
                onPressed: () {
                  if (order) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const OrderStatus()));
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const OrderDetails()));
                  }
                },
                child: Text(
                  track ? 'Track ' : '> ',
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
