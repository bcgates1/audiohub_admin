import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

alertshower({required String message, required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Alert'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

// toastMessage({required String message}) {
//   return Fluttertoast.showToast(
//     msg: message,
//     // toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//   );
// }

snackbarMessage({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

loading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: SizedBox(
        height: kheight * 0.18,
        width: kwidth * 0.4,
        child: const CircularProgressIndicator(),
      ),
    ),
  );
}
