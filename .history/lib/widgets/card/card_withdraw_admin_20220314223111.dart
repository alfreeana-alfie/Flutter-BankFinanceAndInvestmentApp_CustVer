import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/member/withdraw_methods.dart';
import 'package:flutter_banking_app/models/withdraw.dart';
import 'package:flutter_banking_app/pages/admin/team_layout.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../methods/config.dart';

class CardWithdrawAdmin extends StatelessWidget {
  const CardWithdrawAdmin(
      {Key? key,
      required this.withdraw,
      required this.withdrawList,
      required this.index,
      this.userType,
      this.customerId})
      : super(key: key);

  final Withdraw withdraw;
  final List<Withdraw> withdrawList;
  final int index;
  final String? userType, customerId;

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
                              withdraw.transactionCode ?? Field.emptyString,
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
    DateTime tempDate = DateTime.parse(withdraw.createdAt ?? '2021-01-01');
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
                labelDetails: withdraw.name ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.bankName,
                labelDetails: withdraw.bankName ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.branchName,
                labelDetails: withdraw.branchName ?? Field.emptyString),
            // DetailRow(
            //     labelTitle: Str.swiftCode,
            //     labelDetails: withdraw.swiftCode ?? Field.emptyString),
            // DetailRow(
            //     labelTitle: Str.accountHolderName,
            //     labelDetails: withdraw.accountHolderName ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.accountNo,
                labelDetails: withdraw.accountNo ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.accountHolderPhoneNo,
                labelDetails:
                    withdraw.accountHolderPhoneNo ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.currency,
                labelDetails: withdraw.currency ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.amount,
                labelDetails: double.parse(withdraw.amount ?? Field.emptyAmount)
                    .toStringAsFixed(2)),
            DetailRow(
                labelTitle: Str.approved,
                labelDetails: withdraw.approved ?? Field.emptyString),
            DetailRow(labelTitle: Str.created, labelDetails: createdAt),
            // DetailRow(labelTitle: Str.countryCode, labelDetails: withdraw.countryCode ?? Field.emptyString),
            const Gap(20),
            _buildButtonRow(context),
          ],
        ),
      ]),
    );
  }

  _buildButtonRow(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();
    return Row(
      children: [
        Expanded(
          child: RoundedLoadingButton(
            borderRadius: 12,
            height: 40,
            controller: _btnController,
            color: Styles.successColor,
            onPressed: () {
              Map<String, String> body = {'approved': 'approved'};
              Method.edit(
                  context,
                  _btnController,
                  body,
                  Uri.parse(AdminAPI.updateWithdraw.toString() +
                      withdraw.id.toString()),
                  Type.withdraw,
                  TeamLayout(
                    type: Field.create,
                  ),
                  Str.withdrawList,
                  Type.nullable,
                  '');
            },
            child: Text(
              Str.approved.toUpperCase(),
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          child: RoundedLoadingButton(
            borderRadius: 12,
            height: 40,
            color: Styles.dangerColor,
            controller: _btnController,
            onPressed: () {
              Map<String, String> body = {'approved': 'rejected'};
              Method.edit(
                  context,
                  _btnController,
                  body,
                  Uri.parse(AdminAPI.updateWithdraw.toString() +
                      withdraw.id.toString()),
                  Type.withdraw,
                  TeamLayout(
                    type: Field.create,
                  ),
                  Str.withdrawList,
                  Type.nullable,
                  '');
            },
            child: Text(
              Str.reject.toUpperCase(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
