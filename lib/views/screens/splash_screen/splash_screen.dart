import 'dart:async';
import 'package:audiohub_admin/views/screens/home/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wait(context);
    });
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    ));
  }

  wait(BuildContext context) async {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
      },
    );
  }
}
