import 'package:bank_fvisng_admin/models/user.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailRow extends StatelessWidget {
  final String labelTitle;
  final String labelDetails;

  const DetailRow({Key? key, required this.labelTitle, required this.labelDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                labelTitle,
                // style: GoogleFonts.roboto(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: Styles.textColor.withOpacity(0.3),
                // ),
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
            Text(
              ':',
              // style: GoogleFonts.roboto(
              //   fontSize: 15,
              //   fontWeight: FontWeight.w700,
              //   color: Styles.textColor.withOpacity(0.3),
              // ),
              style: Theme.of(context).textTheme.bodyText1
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                  child: Text(
                    labelDetails,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    // style: GoogleFonts.nunitoSans(
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.w500,
                    //   color: Styles.textColor.withOpacity(0.8),
                    // ),
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
