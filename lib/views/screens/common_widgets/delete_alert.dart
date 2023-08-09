import 'package:flutter/material.dart';

Future<dynamic> deleteAlert({required BuildContext context, required Function() onTapfunction}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Do you want to delete'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              onTapfunction();

              Navigator.pop(ctx);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('No'),
          ),
        ],
      ),
    ),
  );
}
