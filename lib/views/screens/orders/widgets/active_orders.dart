import 'package:audiohub_admin/controllers/order_screen_provider/order_screen.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ActiveOrders extends StatelessWidget {
  const ActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    // Initiate data fetching
    Provider.of<OrderScreen>(context, listen: false).activeOrderScreen();

    return Consumer<OrderScreen>(builder: (context, orderValue, child) {
      if (orderValue.orderList.isNotEmpty) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: kwidth * 0.05),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                int length = orderValue.orderList[index]['orderItems'].length;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kwidth * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: kwidth * 0.2,
                        height: kwidth * 0.2,
                        child: length == 1
                            ? Image.network(
                                orderValue.orderList[index]['orderItems']['0']['image'],
                                fit: BoxFit.cover,
                              )
                            : OverflowBox(
                                maxHeight: 200,
                                // maxWidth: 100,
                                child: LottieBuilder.asset(
                                  'assets/lotties/order_group_cart.json',
                                ),
                              ),
                      ),
                      SizedBox(
                        width: kwidth * 0.6,
                        height: kwidth * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //to check if order is group order or not
                            Text(
                              length == 1
                                  ? orderValue.orderList[index]['orderItems']['0']['name']
                                  : 'Group Order',
                            ),
                            Text(
                              'Order# ${orderValue.orderList[index]['orderId']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Date: ${orderValue.orderList[index]['orderDateTime']}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: kwidth * 0.1,
                        height: kwidth * 0.2,
                        child: IconButton(
                          onPressed: () {
                            orderValue.mainIndex = index;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const OrderDetails(
                                      isActiveOrder: true,
                                    )));
                          },
                          iconSize: 40,
                          icon: const Icon(
                            Icons.navigate_next_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: orderValue.orderList.length,
              reverse: true,
            ),
          ),
        );
      } else {
        return const Center(
          child: Text('No Orders'),
        );
      }
    });
  }
}
