import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/loans.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CardLoan extends StatelessWidget {
  const CardLoan({Key? key, required this.loan}) : super(key: key);

  final Loan loan;

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
                            Text(loan.transactionCode ?? Field.remarks,
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.ellipsis,),
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

    // Status
    String? status;
    switch (loan.status) {
      case '1':
        status = 'Pending';
        break;
      case '2':
        status = 'Approved';
        break;
      case '3':
        status = 'Rejected/Canceled';
        break;
      default:
        status = 'Default';
    }

    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(labelTitle: Str.loanId, labelDetails: loan.loanId ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.loanProduct, labelDetails: loan.loanProductId ?? Field.emptyString),
            DetailRow(labelTitle: Str.currency, labelDetails: loan.currencyId ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.appliedAmount, labelDetails: loan.appliedAmount ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.totalPayable, labelDetails: loan.totalPayable ?? Field.emptyString),
            DetailRow(labelTitle: Str.amountPaid, labelDetails: loan.totalPaid ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.dueAmount, labelDetails: loan.totalPaid ?? Field.emptyString),
            DetailRow(labelTitle: Str.releaseDate, labelDetails: loan.releaseDate ?? Field.emptyString),
            DetailRow(labelTitle: Str.status, labelDetails: status),
            const Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Attachment(s)', style: Styles.cardTitle),
                const Gap(7),
                RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Str.membershipId,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch(loan.attachment!)) {
                                await launch(loan.attachment!);
                              } else {
                                throw 'Could not launch Privacy Policy Link';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                  const Gap(7),
                  loan.nationalIdentityCard != null ? RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Str.nationalIdentityCard,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch(loan.nationalIdentityCard!)) {
                                await launch(loan.nationalIdentityCard!);
                              } else {
                                throw 'Could not launch Privacy Policy Link';
                              }
                            },
                        ),
                      ],
                    ),
                  ): const Gap(0),
                  const Gap(7),
                  loan.bankStatement != null ? RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Str.bankStatement,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch(loan.bankStatement!)) {
                                await launch(loan.bankStatement!);
                              } else {
                                throw 'Could not launch Privacy Policy Link';
                              }
                            },
                        ),
                      ],
                    ),
                  ) : const Gap(0),
              ],
            )
            // _buildButtonRow(context),
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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => EditUserPage(
              //       user: users,
              //     ),
              //   ),
              // );
            },
            child: Text(
              Str.edit.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
        ),
        const Gap(20),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _showMyDialog(context);
            },
            child: Text(
              Str.delete.toUpperCase(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.dangerColor),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Str.deleteConfirmation),
          content: Text(Str.areYouSure),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Str.cancel.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, primary: Styles.primaryColor),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: Text(
                Str.delete.toUpperCase(),
                style: Theme.of(context).textTheme.button,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, primary: Styles.dangerColor),
            ),
          ],
        );
      },
    );
  }
}
