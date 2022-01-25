import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/other_bank_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/pages/admin/other_banks/update_bank.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardBank extends StatelessWidget {
  const CardBank({Key? key, required this.bank, required this.bankList, required this.index}) : super(key: key);

  final Bank bank;
  final List<Bank> bankList;
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
                            Text(bank.name ?? Field.emptyString,
                                style: Theme.of(context).textTheme.headline6),
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
                      Str.viewDetailsTxt,
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
    
    DateTime tempDate = DateTime.parse(bank.createdAt ?? '-');
    String createdAt = DateFormat('yyyy-MM-dd hh:mm:ss').format(tempDate);

    
    // Status
    String? status;
    switch (bank.status) {
      case 0:
        status = 'NOT ACTIVE';
        break;
      case 1:
        status = 'ACTIVE';
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
            DetailRow(labelTitle: Str.nameTxt, labelDetails: bank.name ?? Field.emptyString),
            DetailRow(labelTitle: Str.swiftCodeTxt, labelDetails: bank.swiftCode ?? Field.emptyString),
            DetailRow(labelTitle: Str.bankCountryTxt, labelDetails: bank.bankCountry ?? Field.emptyString),
            DetailRow(labelTitle: Str.bankCurrencyTxt, labelDetails: bank.bankCurrency.toString()),
            DetailRow(labelTitle: Str.minTransferAmtTxt, labelDetails: bank.minTransferAmt ?? Field.emptyString),
            DetailRow(labelTitle: Str.maxTransferAmtTxt, labelDetails: bank.maxTransferAmt ?? Field.emptyString),
            DetailRow(labelTitle: Str.fixedChargeTxt, labelDetails: bank.fixedCharge ?? Field.emptyString),
            DetailRow(labelTitle: Str.chargeInPercentageTxt, labelDetails: bank.chargeInPercentage ?? Field.emptyString),
            DetailRow(labelTitle: Str.descriptionsTxt, labelDetails: bank.descriptions ?? Field.emptyString),
            DetailRow(labelTitle: Str.statusTxt, labelDetails: status),
            DetailRow(labelTitle: Str.createdTxt, labelDetails: createdAt),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateOtherBank(
                    bank: bank,
                  ),
                ),
              );
            },
            child: Text(
              Str.editTxt.toUpperCase(),
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
              Str.deleteTxt.toUpperCase(),
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
          title: Text(Str.deleteConfirmationTxt),
          content: Text(Str.areYouSureTxt),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Str.cancelTxt.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, primary: Styles.primaryColor),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
                bankList.removeAt(index);
                
                CustomToast.showMsg('Deleting...', Styles.dangerColor);

                Future.delayed(const Duration(milliseconds: 1000), () {
                  OtherBankMethods.delete(
                      context, bank.id.toString());
                  Navigator.popAndPushNamed(context, RouteSTR.otherBankList);
                });
              },
              child: Text(
                Str.deleteTxt.toUpperCase(),
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
