import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAppBar extends StatelessWidget {
  const ViewAppBar({required this.title, required this.widgets});

  final String title;
  final Widget widgets;

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
      actions: [widgets],
    );
  }
}
