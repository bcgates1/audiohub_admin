import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderAppbar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: kwidth * 0.15,
      title: Text(
        'ORDERS',
        style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      shadowColor: Colors.black,
      elevation: 5,
      backgroundColor: Colors.white,
      bottom: const TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: [
            Tab(
              text: 'Active',
            ),
            Tab(
              text: 'Completed',
            ),
          ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.6);
}
