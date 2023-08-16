import 'package:audiohub_admin/controllers/add_product_provider/add_product_image.dart';
import 'package:audiohub_admin/controllers/add_product_provider/text_editing_controller.dart';
import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    kheight = MediaQuery.of(context).size.height;
    kwidth = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddProductTextController()),
        ChangeNotifierProvider(create: (_) => ProductImageProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
