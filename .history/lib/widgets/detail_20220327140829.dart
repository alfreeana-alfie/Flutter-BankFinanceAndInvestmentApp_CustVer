import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';

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
            Expanded(
              flex: 1,
              child: Text(
                labelTitle,
                // style: GoogleFonts.roboto(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: Styles.textColor.withOpacity(0.3),
                // ),
                style: Styles.cardTitle
              ),
            ),
            const Text(
              ':',
              style: Styles.cardTitle
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
                  child: Text(
                    labelDetails,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.cardDetails
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
