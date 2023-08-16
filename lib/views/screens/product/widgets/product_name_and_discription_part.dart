import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProductNameAndDescription extends StatelessWidget {
  ProductNameAndDescription(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.discount,
      required this.category});
  final String name;
  final String description;
  final int price;
  final int discount;
  final String category;
  final NumberFormat numberformat = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kheight * 0.015),
        Text(
          category,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kheight * 0.015),
        Row(
          children: [
            Text(
              '$discount% OFF',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(
              width: kwidth * 0.08,
            ),
            Text(
              numberformat.format(price),
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'About this item',
              style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
            ),
            Text(
              description,
              style: GoogleFonts.inter(fontSize: 12),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(height: kheight * 0.01),
      ],
    );
  }
}
