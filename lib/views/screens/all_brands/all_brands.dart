import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCom(title: 'ALL BRAND'),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: kheight * 0.32,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              //all brands
            },
            child: InkWell(
              onTap: () {
                //brand products
              },
              child: Column(
                children: [
                  Image.network(allbrandsony),
                  const Text(
                    'Sony',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )),
        padding: const EdgeInsets.all(8),
        itemCount: 3,
      ),
    );
  }
}
