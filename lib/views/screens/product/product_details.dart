import 'package:audiohub_admin/views/core/style.dart';
import 'package:audiohub_admin/views/screens/common_widgets/appbar.dart';
import 'package:audiohub_admin/views/screens/product/widgets/scrolling_part.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppbarCom(title: 'Product'),
        body: Column(
          children: [
            const ProductScrollingPart(),
            SizedBox(
              height: kheight * 0.08,
              // ignore: prefer_const_constructors
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (context) => const CheckOutScrn()));
                  //   },
                  //   style: _buttonstyle(),
                  //   child: _buttonchild('BUY NOW'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => const AddToCartAlert(),
                  //     );
                  //   },
                  //   style: _buttonstyle(),
                  //   child: _buttonchild('ADD TO CART'),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonstyle() {
    return ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.black),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  }

  Widget _buttonchild(String text) {
    return SizedBox(
        height: kheight * 0.06,
        width: kwidth * 0.27,
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
        )));
  }
}
