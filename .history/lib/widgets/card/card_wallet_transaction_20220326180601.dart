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

import 'package:http/http.dart' as http;

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
            onPressed: () async {
              //Create a new PDF document
              PdfDocument document = PdfDocument();
              //Create a PdfGrid class.
              PdfGrid grid = PdfGrid();

              //Create the header with specific bounds
              PdfPageTemplateElement header =
                  PdfPageTemplateElement(Rect.fromLTWH(0, 0, 0, 90));

              //Create the date and time field
              PdfDateTimeField dateAndTimeField = PdfDateTimeField(
                  font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));
              dateAndTimeField.date = DateTime(2020, 2, 10, 13, 13, 13, 13, 13);
              dateAndTimeField.dateFormatString = 'E, MM.dd.yyyy';

              

              var url =
                  "https://villasearch.de/assets/assets/images/logoTransparent.png";
              var response = await http.get(Uri.parse(url));
              var data = response.bodyBytes;

              //Create a bitmap object.
              PdfBitmap image = PdfBitmap(data);

              //Add the header at top of the document
              document.template.top = header;

              //Add columns to the grid.
              grid.columns.add(count: 3);

              //Add a header to the grid.
              grid.headers.add(1);

              //Add rows to the grid.
              PdfGridRow headerTable = grid.headers[0];
              headerTable.cells[0].value = 'Employee ID';
              headerTable.cells[1].value = 'Employee Name';
              headerTable.cells[2].value = 'Salary';
              //Add rows to the grid.
              PdfGridRow row = grid.rows.add();
              row.cells[0].value = 'E01';
              row.cells[1].value = 'Clay';
              row.cells[2].value = '\$10,000';
              row = grid.rows.add();
              row.cells[0].value = 'E02';
              row.cells[1].value = 'Simon';
              row.cells[2].value = '\$12,000';
              PdfGridBuiltInStyleSettings tableStyleOption =
                  PdfGridBuiltInStyleSettings();
              tableStyleOption.applyStyleForBandedRows = true;
              tableStyleOption.applyStyleForHeaderRow = true;
              //Apply built-in table style.
              grid.applyBuiltInStyle(
                  PdfGridBuiltInStyle.listTable6ColorfulAccent1,
                  settings: tableStyleOption);
              //Draw the grid.
              grid.draw(
                  page: document.pages.add(),
                  bounds: const Rect.fromLTWH(10, 10, 0, 0));

              //Add a page to the document and get page graphics
              PdfGraphics graphics = document.pages[0].graphics;

              //Watermark image
              PdfGraphicsState state = graphics.save();
              graphics.setTransparency(0.25);
              graphics.drawImage(image, const Rect.fromLTWH(0, 0, 512, 512));
              graphics.restore(state);

              //Create the footer with specific bounds
              PdfPageTemplateElement footer =
                  PdfPageTemplateElement(Rect.fromLTWH(0, 0, 0, 50));

              //Create the page number field
              PdfPageNumberField pageNumber = PdfPageNumberField(
                  font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

              //Sets the number style for page number
              pageNumber.numberStyle = PdfNumberStyle.upperRoman;

              //Create the page count field
              PdfPageCountField count = PdfPageCountField(
                  font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

              //set the number style for page count
              count.numberStyle = PdfNumberStyle.upperRoman;

              //Create the date and time field
              PdfDateTimeField dateTimeField = PdfDateTimeField(
                  font: PdfStandardFont(PdfFontFamily.helvetica, 19),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)));

              //Sets the date and time
              dateTimeField.date = DateTime(2020, 2, 10, 13, 13, 13, 13, 13);

              //Sets the date and time format
              dateTimeField.dateFormatString = 'hh\':\'mm\':\'ss';

              //Create the composite field with page number page count
              PdfCompositeField compositeField = PdfCompositeField(
                  font: PdfStandardFont(PdfFontFamily.helvetica, 12),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                  text: 'Page {0} of {1}',
                  fields: <PdfAutomaticField>[pageNumber, count]);
              compositeField.bounds = footer.bounds;

              //Add the composite field in footer
              compositeField.draw(
                  footer.graphics,
                  Offset(
                      0,
                      50 -
                          PdfStandardFont(PdfFontFamily.helvetica, 12).height));

              //Add the footer at the bottom of the document
              document.template.bottom = footer;

              //Save the document.
              List<int> bytes = document.save();
              //Dispose the document.
              document.dispose();

              saveAndLaunchFile(bytes, '${transaction.transactionCode}.pdf');
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
