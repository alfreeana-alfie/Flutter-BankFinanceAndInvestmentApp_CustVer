import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.secondaryColor,
      centerTitle: false,
      title: Text(
        title,
        style: GoogleFonts.roboto(),
      ),
      elevation: 0.5,
    );
  }
}
