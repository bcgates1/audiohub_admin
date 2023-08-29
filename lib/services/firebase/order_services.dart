import 'package:audiohub_admin/views/screens/common_widgets/alert_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<void> updateOrderStatusByOrderId({
  required String orderId,
  required String orderStatus,
}) async {
  try {
    CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');

    QuerySnapshot querySnapshot = await ordersCollection.get();
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        List<Map<String, dynamic>> orderLists = (docSnapshot.get('orderLists') as List)
            .map((orderData) => orderData as Map<String, dynamic>)
            .toList();

        for (var orderData in orderLists) {
          if (orderData['orderId'] == orderId) {
            if (orderStatus == 'shippingdate') {
              orderData['shippingdate'] =
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString();
            } else if (orderStatus == 'deliverydate') {
              orderData['deliverydate'] =
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString();
            }
            // Update the orderLists array with the modified data
            await docSnapshot.reference.update({'orderLists': orderLists});
            // Exit the loop since the order has been found and updated
            return;
          }
        }
      }
    }
  } catch (e) {
    toastMessage(message: e.toString());
  }
}
