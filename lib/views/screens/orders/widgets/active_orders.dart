import 'package:audiohub_admin/services/firebase/fetch_product.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/orders/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ActiveOrders extends StatelessWidget {
  const ActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.topCenter,
              child: FutureBuilder(
                future: FetchDataFirebase.fetchAllActiveOrders(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: kwidth * 0.05),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int length = snapshot.data![index]['orderItems'].length;

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
                                          snapshot.data![index]['orderItems']['0']['image'][0],
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
                                            ? snapshot.data![index]['orderItems']['0']['name']
                                            : 'Group Order',
                                      ),
                                      Text(
                                        'Order# ${snapshot.data![index]['orderId']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Date: ${snapshot.data![index]['orderDateTime']}',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: kwidth * 0.1,
                                  height: kwidth * 0.2,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => OrderDetails(
                                                orderList: snapshot.data!,
                                                mainIndex: index,
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
                        itemCount: snapshot.data!.length,
                        reverse: true,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No Orders'),
                    );
                  }
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
