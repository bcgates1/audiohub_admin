import 'package:audiohub_admin/views/core/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarCom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  const AppbarCom({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.black,
      leadingWidth: kwidth * 0.13,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          size: 30,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: action ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
