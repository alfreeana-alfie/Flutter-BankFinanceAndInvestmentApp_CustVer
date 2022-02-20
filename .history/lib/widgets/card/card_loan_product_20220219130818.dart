import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/loan_product_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/loan_product.dart';
import 'package:flutter_banking_app/pages/admin/loan_managements/loan_product_layout.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardLoanProduct extends StatelessWidget {
  const CardLoanProduct(
      {Key? key,
      required this.product,
      required this.productList,
      required this.index})
      : super(key: key);

  final LoanProduct product;
  final List<LoanProduct> productList;
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
                            Text(product.name ?? Field.emptyString,
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
    switch (product.status) {
      case '0':
        status = 'NOT ACTIVE';
        break;
      case '1':
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
            DetailRow(
                labelTitle: Str.name,
                labelDetails: product.name ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.minAmt,
                labelDetails: product.minAmt ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.maxAmt,
                labelDetails: product.maxAmt ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.description,
                labelDetails: product.description ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.interestRate,
                labelDetails: product.interestRate ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.interestType,
                labelDetails: product.interestType ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.term, labelDetails: product.term.toString()),
            DetailRow(
                labelTitle: Str.termPeriod,
                labelDetails: product.termPeriod ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.status,
                labelDetails: status),
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
                  builder: (context) => LoanProductLayout(
                    loanProduct: product,
                    type: Field.update,
                  ),
                ),
              );
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
                productList.removeAt(index);

                CustomToast.showMsg('Deleting...', Styles.dangerColor);

                Future.delayed(const Duration(milliseconds: 1000), () {
                  LoanProductMethods.delete(context, product.id.toString());
                  Navigator.popAndPushNamed(context, RouteSTR.loanProductList);
                });
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
