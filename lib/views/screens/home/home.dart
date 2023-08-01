import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/add_product/add_product.dart';
import 'package:audiohub_admin/views/screens/add_brand/add_brand.dart';
import 'package:audiohub_admin/views/screens/all_brands/all_brands.dart';
import 'package:audiohub_admin/views/screens/all_products/all_product.dart';
import 'package:audiohub_admin/views/screens/home/widgets/home_buttons.dart';
import 'package:audiohub_admin/views/screens/orders/orders.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "AudioHub ADMIN",
            style: googleblackbold,
          ),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const AllProducts()));
                },
                text: 'ALL PRODUCTS',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const AllBrands()));
                },
                text: 'ALL BRANDS',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const AddBrand()));
                },
                text: 'ADD BRAND',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProduct()));
                },
                text: 'ADD PRODUCTS',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const Orders()));
                },
                text: 'ORDERS',
              ),
            ],
          ),
        ));
  }
}
