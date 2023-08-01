import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.imagepath,
    required this.discount,
    required this.price,
    required this.name,
    required this.category,
  });
  final String imagepath;
  final int discount;
  final int price;
  final String name;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              width: kwidth * 0.5, height: kheight * 0.2, fit: BoxFit.fitHeight, imagepath),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                      )),
                  Text(category, style: GoogleFonts.inter(color: Colors.black)),
                  Row(
                    children: [
                      Text(
                        '$discount% OFF',
                        style: GoogleFonts.inter(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text('₹$price')
                    ],
                  ),
                  Text('Delivery in 5 days', style: GoogleFonts.inter(fontSize: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
