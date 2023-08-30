import 'package:audiohub_admin/controllers/order_screen_provider/order_screen.dart';
import 'package:audiohub_admin/utils/app_constants.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/orders/widgets/change_status.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    this.isActiveOrder = false,
  });
  final bool isActiveOrder;

  @override
  Widget build(BuildContext context) {
    final mainOrderValue = Provider.of<OrderScreen>(context, listen: false);
    final detailScreenValue = Provider.of<OrderScreenDetails>(context, listen: false);
    detailScreenValue.orderList = mainOrderValue.orderList;
    detailScreenValue.mainIndex = mainOrderValue.mainIndex;

    return Consumer<OrderScreenDetails>(
      builder: (context, orderValue, child) {
        return WillPopScope(
          onWillPop: () async {
            if (isActiveOrder) {
              mainOrderValue.activeOrderScreen();
            }
            return true;
          },
          child: Scaffold(
            appBar: const AppbarCom(title: 'Order Details'),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order# ${orderValue.orderList[orderValue.mainIndex]['orderId']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderValue.orderList[orderValue.mainIndex]['orderItems'].length,
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
                                    orderValue.orderList[orderValue.mainIndex]['orderItems']
                                        ['$index']['image'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                title: Text(
                                  orderValue.orderList[orderValue.mainIndex]['orderItems']['$index']
                                      ['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Price: ${numberformat.format(orderValue.orderList[orderValue.mainIndex]['orderItems']['$index']['price'])}'),
                                    Text(
                                        'Total: ${numberformat.format(orderValue.orderList[orderValue.mainIndex]['orderItems']['$index']['price'] * orderValue.orderList[orderValue.mainIndex]['orderItems']['$index']['quantity'])}'),
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
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${orderValue.orderList[orderValue.mainIndex]['orderItems']['$index']['quantity']}',
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
                        'Total Amount: ${numberformat.format(int.parse(orderValue.orderList[orderValue.mainIndex]['orderAmount']))}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'Payment Method: ${orderValue.orderList[orderValue.mainIndex]['paymentMethod']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Delivery Address:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Column(
                      children: [
                        Text(
                            '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['name']}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['houseNo']}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['city']}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['district']}, ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['state']}, ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['pincode']}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['mobile']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${orderValue.orderList[orderValue.mainIndex]['orderAddress']['landmark']}',
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
                          date: orderValue.orderList[orderValue.mainIndex]['orderDateTime']
                              .toString(),
                          tracker_details: [
                            // TrackerDetails contains detailed information about a specific event in the order tracking process.
                            TrackerDetails(
                              title: "Your order will be shipping soon",
                              datetime: orderValue.orderList[orderValue.mainIndex]['orderDateTime']
                                  .toString(),
                            ),
                          ],
                        ),
                        if (orderValue.orderList[orderValue.mainIndex]['shippingdate'] != '')
                          TrackerData(
                            title: 'Order Shipped',
                            date: orderValue.orderList[orderValue.mainIndex]['shippingdate']
                                .toString(),
                            tracker_details: [
                              // TrackerDetails contains detailed information about a specific event in the order tracking process.
                              TrackerDetails(
                                title: "Your order was shipped",
                                datetime: orderValue.orderList[orderValue.mainIndex]['shippingdate']
                                    .toString(),
                              ),
                            ],
                          ),
                        if (orderValue.orderList[orderValue.mainIndex]['deliverydate'] != '')
                          TrackerData(
                            title: 'Order delivered',
                            date: orderValue.orderList[orderValue.mainIndex]['deliverydate']
                                .toString(),
                            tracker_details: [
                              // TrackerDetails contains detailed information about a specific event in the order tracking process.
                              TrackerDetails(
                                title: "Your order was delivered",
                                datetime: orderValue.orderList[orderValue.mainIndex]['deliverydate']
                                    .toString(),
                              )
                            ],
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: (orderValue.orderList[orderValue.mainIndex]['shippingdate'] ==
                        '' ||
                    orderValue.orderList[orderValue.mainIndex]['deliverydate'] == '')
                ? FloatingActionButton.extended(
                    onPressed: () {
                      if (orderValue.orderList[orderValue.mainIndex]['shippingdate'] == '') {
                        changeStatus(
                          context: context,
                          orderId: orderValue.orderList[orderValue.mainIndex]['orderId'],
                          status: 'order shipped',
                          statusCheckName: 'shippingdate',
                        );
                      } else if (orderValue.orderList[orderValue.mainIndex]['deliverydate'] == '') {
                        changeStatus(
                          context: context,
                          orderId: orderValue.orderList[orderValue.mainIndex]['orderId'],
                          status: 'order delivered',
                          statusCheckName: 'deliverydate',
                        );
                      }
                    },
                    label: const Text('Change Status'),
                  )
                : null,
          ),
        );
      },
    );
  }
}
