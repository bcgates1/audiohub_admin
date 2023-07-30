import 'package:flutter/material.dart';

validationAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Alert'),
      content: const Text('Brand name and Image are required'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'))
      ],
    ),
  );
}
