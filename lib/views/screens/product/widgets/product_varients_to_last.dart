import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductVarientsToLast extends StatelessWidget {
  const ProductVarientsToLast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titletext('Available colors'),
        SizedBox(height: kheight * 0.01),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: kheight * 0.045,
              crossAxisSpacing: kheight * 0.005,
              mainAxisSpacing: kheight * 0.005),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Center(
            child: Container(
                decoration: BoxDecoration(
                    color: index == 3 ? const Color.fromARGB(255, 151, 205, 255) : Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    varients[index],
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                )),
          ),
          itemCount: varients.length,
        ),
        SizedBox(height: kheight * 0.01),
        Text(
          'Review',
          style: GoogleFonts.inter(color: Colors.black),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              _detailtext('Username\nI Like it very much, Amazing product', true),
          itemCount: 3,
        ),
        SizedBox(height: kheight * 0.02),
        ElevatedButton(
          onPressed: () {
            //Review page
          },
          style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(3),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              surfaceTintColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(ContinuousRectangleBorder())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All reviews',
                style: GoogleFonts.inter(color: Colors.black),
              ),
              const Icon(
                Icons.navigate_next_outlined,
                size: 30,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _titletext(String text) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: kheight * 0.01),
      Text(
        text,
        style: GoogleFonts.inter(color: Colors.black),
      )
    ]);
  }

  Widget _detailtext(String text, bool isblack) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: kheight * 0.01),
      Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, color: isblack ? Colors.black : Colors.grey),
      )
    ]);
  }
}
