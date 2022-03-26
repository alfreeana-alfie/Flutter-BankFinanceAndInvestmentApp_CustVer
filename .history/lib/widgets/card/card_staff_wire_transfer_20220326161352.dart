import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/deposit.dart';
import 'package:flutter_banking_app/pages/admin/users/assign_wire_transfer.dart';
import 'package:flutter_banking_app/pages/admin/users/submit_attachment.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CardStaffWireTransfer extends StatelessWidget {
  const CardStaffWireTransfer(
      {Key? key,
      required this.deposit,
      required this.depositList,
      required this.index})
      : super(key: key);

  final Deposit deposit;
  final List<Deposit> depositList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Values.horizontalValue,
          right: Values.horizontalValue,
        ),
        child: Card(
          elevation: 0.2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: Container(
                  color: Styles.thirdColor,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      iconColor: Styles.accentColor,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/payment_request.svg',
                              width: 30,
                              height: 30,
                              color: Styles.accentColor,
                            ),
                            const Gap(20),
                            Text(
                              deposit.userName ?? Field.emptyString,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                    collapsed: const Text(
                      '',
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var _ in Iterable.generate(5))
                          const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'const',
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Column(
                        children: [
                          Expandable(
                            collapsed: buildCollapsed1(),
                            expanded: buildExpanded1(context),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCollapsed1() {
    return Container(
      color: Styles.accentColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      Str.viewDetails,
                      style: Styles.cardTitle,
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  buildExpanded1(BuildContext context) {
    DateTime tempDate = DateTime.parse(deposit.createdAt ?? '-');
    String createdAt = DateFormat('yyyy-MM-dd hh:mm:ss').format(tempDate);

    double rate = double.parse(deposit.fee!);
    double amount = double.parse(deposit.amount!);
    double grandTotal = amount - rate;
    // Status
    // String? status;
    // switch (deposit.status) {
    //   case '1':
    //     status = 'Pending';
    //     break;
    //   case '2':
    //     status = 'Approved';
    //     break;
    //   case '3':
    //     status = 'Rejected/Canceled';
    //     break;
    //   default:
    //     status = 'Default';
    // }

    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(
                labelTitle: Str.name,
                labelDetails: deposit.userName ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.currency,
                labelDetails: deposit.name ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.amount,
                labelDetails: deposit.amount ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.fee,
                labelDetails: deposit.fee ?? Field.emptyAmount),
            DetailRow(
                labelTitle: Str.grandTotal,
                labelDetails: grandTotal.toStringAsFixed(2)),
            DetailRow(labelTitle: Str.created, labelDetails: createdAt),
            // DetailRow(labelTitle: Str.type, labelDetails: deposit.type ?? Field.emptyString),
            // DetailRow(
            //     labelTitle: Str.method, labelDetails: deposit.method ?? Field.emptyString),
            // DetailRow(labelTitle: Str.status, labelDetails: status),
            deposit.attachment == null
                ? _buildButtonRow(context)
                : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 1, child: Text('Attachment(s)', style: Styles.cardTitle)),
                // const Gap(7),
                const Text(
              ':',
              style: Styles.cardTitle
            ),
                Expanded(
                  flex: 2,
                  child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${deposit.transactionCode}.pdf',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(deposit.attachment!)) {
                                  await launch(deposit.attachment!);
                                } else {
                                  throw 'Could not launch Privacy Policy Link';
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  _buildButtonRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SubmitAttachment(
                    transactionId: deposit.id.toString(),
                  ),
                ),
              );
            },
            child: Text(
              Str.submitAttachment.toUpperCase(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.infoColor),
          ),
        ),
      ],
    );
  }
}
