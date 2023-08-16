import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

toastMessage({required String message}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    // There are other options for gravity, check the documentation
  );
}

snackbarMessage({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

loading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.white,
          secondRingColor: const Color.fromARGB(255, 2, 2, 2),
          thirdRingColor: const Color.fromARGB(255, 0, 0, 0),
          size: 80,
        ),
      );
    },
  );
}
