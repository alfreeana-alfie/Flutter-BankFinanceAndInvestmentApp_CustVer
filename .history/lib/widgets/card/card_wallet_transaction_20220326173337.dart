import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/mobile.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CardWalletTransaction extends StatelessWidget {
  const CardWalletTransaction(
      {Key? key,
      required this.transaction,
      required this.transactionList,
      required this.index})
      : super(key: key);

  final WalletTransaction transaction;
  final List<WalletTransaction> transactionList;
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
                              transaction.transactionCode ?? 'ERROR',
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
    // Status
    String? method;
    switch (transaction.method) {
      case 'send_money':
        method = 'Send Money';
        break;
      case 'deposit':
        method = 'Deposit';
        break;
      case 'wire_transfer':
        method = 'Wire Transfer';
        break;
      case 'top_up':
        method = 'Top Up Wallet';
        break;
      case 'sms_subcribed':
        method = 'SMS Subcription';
        break;
      default:
        method = 'Default';
    }

    DateTime tempDate = DateTime.parse(transaction.createdAt ?? '2021-01-01');
    String createdAt = DateFormat(Styles.formatDate).format(tempDate);

    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(
                labelTitle: Str.name,
                labelDetails: transaction.userName ?? 'User'),
            DetailRow(
                labelTitle: Str.currency,
                labelDetails: transaction.currency ?? 'NGN'),
            DetailRow(
                labelTitle: Str.amount,
                labelDetails:
                    double.parse(transaction.amount!).toStringAsFixed(2)),
            DetailRow(
                labelTitle: Str.rateAmount,
                labelDetails: transaction.rateAmount ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.grandTotal,
                labelDetails: transaction.grandTotal ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.paymentMethod,
                labelDetails: transaction.paymentMethod ?? Field.emptyString),
            DetailRow(labelTitle: Str.method, labelDetails: method),
            DetailRow(
                labelTitle: Str.drCr,
                labelDetails: transaction.creditDebit ?? Field.emptyString),
            DetailRow(labelTitle: Str.created, labelDetails: createdAt),
            _buildButtonRow(context),
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
              //Create a new PDF document
              PdfDocument document = PdfDocument();
              // final page = document.pages.add();

              // Add the pages to the document
              for (int i = 1; i <= 1; i++) {
                // document.pages.add().graphics.drawString(
                //     'page$i', PdfStandardFont(PdfFontFamily.timesRoman, 11),
                //     bounds: Rect.fromLTWH(250, 0, 615, 100));
              }

//Create the header with specific bounds
              PdfPageTemplateElement header = PdfPageTemplateElement(
                  Rect.fromLTWH(
                      0, 0, document.pages[0].getClientSize().width, 300));

//Create the date and time field
              PdfDateTimeField dateAndTimeField = PdfDateTimeField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));
              dateAndTimeField.date = DateTime(2020, 2, 10, 13, 13, 13, 13, 13);
              dateAndTimeField.dateFormatString = 'E, MM.dd.yyyy';

//Create the composite field with date field
              PdfCompositeField compositefields = PdfCompositeField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                  text: '{0}      Header',
                  fields: <PdfAutomaticField>[dateAndTimeField]);

//Add composite field in header
              compositefields.draw(
                  header.graphics,
                  Offset(
                      0,
                      50 -
                          PdfStandardFont(PdfFontFamily.timesRoman, 11)
                              .height));

//Add the header at top of the document
              document.template.top = header;

//Create the footer with specific bounds
              PdfPageTemplateElement footer = PdfPageTemplateElement(
                  Rect.fromLTWH(
                      0, 0, document.pages[0].getClientSize().width, 50));

//Create the page number field
              PdfPageNumberField pageNumber = PdfPageNumberField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the number style for page number
              pageNumber.numberStyle = PdfNumberStyle.upperRoman;

//Create the page count field
              PdfPageCountField count = PdfPageCountField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//set the number style for page count
              count.numberStyle = PdfNumberStyle.upperRoman;

//Create the date and time field
              PdfDateTimeField dateTimeField = PdfDateTimeField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the date and time
              dateTimeField.date = DateTime(2020, 2, 10, 13, 13, 13, 13, 13);

//Sets the date and time format
              dateTimeField.dateFormatString = 'hh\':\'mm\':\'ss';

//Create the composite field with page number page count
              PdfCompositeField compositeField = PdfCompositeField(
                  font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                  text: 'Page {0} of {1}, Time:{2}',
                  fields: <PdfAutomaticField>[
                    pageNumber,
                    count,
                    dateTimeField
                  ]);
              compositeField.bounds = footer.bounds;

//Add the composite field in footer
              compositeField.draw(
                  footer.graphics,
                  Offset(
                      290,
                      50 -
                          PdfStandardFont(PdfFontFamily.timesRoman, 19)
                              .height));

//Add the footer at the bottom of the document
              document.template.bottom = footer;


//Save the document.
              List<int> bytes = document.save();
//Dispose the document.
              document.dispose();

              saveAndLaunchFile(bytes, '${transaction.transactionCode}.pdf');
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => UpdateWireTransfer(
              //       transaction: transaction,
              //     ),
              //   ),
              // );
            },
            child: Text(
              Str.print.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
        ),
        // const Gap(20),
        // Expanded(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       _showMyDialog(context);
        //     },
        //     child: Text(
        //       Str.delete.toUpperCase(),
        //       style: GoogleFonts.nunitoSans(
        //         fontSize: 14,
        //         fontWeight: FontWeight.bold,
        //         color: Styles.primaryColor,
        //         letterSpacing: 0.5,
        //       ),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //         elevation: 0.0, primary: Styles.dangerColor),
        //   ),
        // ),
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
