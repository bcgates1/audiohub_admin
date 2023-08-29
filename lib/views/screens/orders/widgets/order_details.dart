import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/utils/app_constants.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/change_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {super.key, required this.mainIndex, required this.orderList, this.activeOrder = true});
  final int mainIndex;
  final List orderList;
  final bool activeOrder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: activeOrder
                    ? FetchDataFirebase.fetchAllActiveOrders()
                    : FetchDataFirebase.fetchAllCompletedOrders(),
                builder: (context, snapshot) {
                  return Scaffold(
                    appBar: const AppbarCom(title: 'Order Details'),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order# ${orderList[mainIndex]['orderId']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: orderList[mainIndex]['orderItems'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ListTile(
                                        contentPadding: const EdgeInsets.all(5),
                                        leading: SizedBox(
                                          width: kwidth * 0.2,
                                          child: Image.network(
                                            orderList[mainIndex]['orderItems']['$index']['image'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Text(
                                          orderList[mainIndex]['orderItems']['$index']['name'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Price: ${numberformat.format(orderList[mainIndex]['orderItems']['$index']['price'])}'),
                                            Text(
                                                'Total: ${numberformat.format(orderList[mainIndex]['orderItems']['$index']['price'] * orderList[mainIndex]['orderItems']['$index']['quantity'])}'),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Quantity',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(width: kwidth * 0.01),
                                            Container(
                                              height: kheight * 0.03,
                                              width: kwidth * 0.09,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius:
                                                    const BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${orderList[mainIndex]['orderItems']['$index']['quantity']}',
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                            Text(
                                'Total Amount: ${numberformat.format(int.parse(orderList[mainIndex]['orderAmount']))}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Payment Method: ${orderList[mainIndex]['paymentMethod']}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Text('Delivery Address:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Column(
                              children: [
                                Text('${orderList[mainIndex]['orderAddress']['name']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('${orderList[mainIndex]['orderAddress']['houseNo']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('${orderList[mainIndex]['orderAddress']['city']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${orderList[mainIndex]['orderAddress']['district']}, ',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${orderList[mainIndex]['orderAddress']['state']}, ',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${orderList[mainIndex]['orderAddress']['pincode']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${orderList[mainIndex]['orderAddress']['mobile']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${orderList[mainIndex]['orderAddress']['landmark']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kheight * 0.01,
                            ),
                            OrderTrackerZen(
                              tracker_data: [
                                TrackerData(
                                  title: 'Order Placed',
                                  date: orderList[mainIndex]['orderDateTime'].toString(),
                                  tracker_details: [
                                    // TrackerDetails contains detailed information about a specific event in the order tracking process.
                                    TrackerDetails(
                                      title: "Your order will be shipping soon",
                                      datetime: orderList[mainIndex]['orderDateTime'].toString(),
                                    ),
                                  ],
                                ),
                                if (orderList[mainIndex]['shippingdate'] != '')
                                  TrackerData(
                                    title: 'Order Shipped',
                                    date: orderList[mainIndex]['shippingdate'].toString(),
                                    tracker_details: [
                                      // TrackerDetails contains detailed information about a specific event in the order tracking process.
                                      TrackerDetails(
                                        title: "Your order was shipped",
                                        datetime: orderList[mainIndex]['shippingdate'].toString(),
                                      ),
                                    ],
                                  ),
                                if (orderList[mainIndex]['deliverydate'] != '')
                                  TrackerData(
                                    title: 'Order delivered',
                                    date: orderList[mainIndex]['deliverydate'].toString(),
                                    tracker_details: [
                                      // TrackerDetails contains detailed information about a specific event in the order tracking process.
                                      TrackerDetails(
                                        title: "Your order was delivered",
                                        datetime: orderList[mainIndex]['deliverydate'].toString(),
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: (orderList[mainIndex]['shippingdate'] == '' ||
                            orderList[mainIndex]['deliverydate'] == '')
                        ? FloatingActionButton.extended(
                            onPressed: () {
                              if (orderList[mainIndex]['shippingdate'] == '') {
                                changeStatus(
                                  context: context,
                                  orderId: orderList[mainIndex]['orderId'],
                                  status: 'order shipped',
                                  statusCheckName: 'shippingdate',
                                );
                              } else if (orderList[mainIndex]['deliverydate'] == '') {
                                changeStatus(
                                  context: context,
                                  orderId: orderList[mainIndex]['orderId'],
                                  status: 'order delivered',
                                  statusCheckName: 'deliverydate',
                                );
                              }
                            },
                            label: const Text('Change Status'),
                          )
                        : null,
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
