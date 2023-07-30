import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductNameAndDescription extends StatelessWidget {
  const ProductNameAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sony WH-1000XM5',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kheight * 0.015),
        Text(
          'Wireless Headphone',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kheight * 0.015),
        Row(
          children: [
            Text(
              '70% OFF',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(
              width: kwidth * 0.08,
            ),
            Text(
              '₹28,990',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            )
          ],
        ),
        _titletext('About this item'),
        Text(
          'Industry Leading noise cancellation-two processors control 8 microphones for unprecedented noise cancellation. With Auto NC Optimizer, noise cancelling is automatically optimized based on your wearing conditions and environment.',
          style: GoogleFonts.inter(fontSize: 12),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: kwidth * 0.01),
      ],
    );
  }

  Widget _titletext(String text) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: kwidth * 0.01),
      Text(
        text,
        style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
      )
    ]);
  }
}
