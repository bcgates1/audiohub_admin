import 'package:audiohub_admin/services/firebase/order_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

changeStatus(
    {required BuildContext context,
    required String status,
    required String orderId,
    required String statusCheckName}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Change status',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Do you want to change the status to $status?',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    updateOrderStatusByOrderId(orderId: orderId, orderStatus: statusCheckName);

                    Navigator.of(context).pop();
                  },
                  child: const Text('Change'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
