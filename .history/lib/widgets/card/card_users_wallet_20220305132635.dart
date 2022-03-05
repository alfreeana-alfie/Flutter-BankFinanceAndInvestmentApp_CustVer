import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user_wallet.dart';
import 'package:flutter_banking_app/pages/accountant/update_wallet.dart';
import 'package:flutter_banking_app/pages/member/wallet/add_card.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CardUserWallet extends StatelessWidget {
  const CardUserWallet(
      {Key? key,
      required this.users,
      required this.userList,
      required this.index,
      this.userType})
      : super(key: key);

  final UserWallet users;
  final List<UserWallet> userList;
  final int index;
  final String? userType;

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
                              users.memberId ?? Field.emptyString,
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
    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DetailRow(
            //   labelTitle: Str.id,
            //   labelDetails: users.memberId ?? Field.emptyString,
            // ),
            DetailRow(
                labelTitle: Str.name,
                labelDetails: users.userName ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.phoneNumber,
                labelDetails: users.userPhone ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.currentBalance,
                labelDetails:
                    'NGN ${double.parse(users.amount!).toStringAsFixed(2)}'),
            userType == Field.accountManager
                ? const Gap(0)
                : _buildButtonRow(context),
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
                  builder: (context) => UpdateWallet(
                    customerId: users.userId,
                    walletId: users.id.toString(),
                    accountId: '1',
                    walletBalance: users.amount,
                    type: Type.withdraw,
                  ),
                ),
              );
            },
            child: userType == Field.accountant
                ? Text(Str.withdraw.toUpperCase())
                : Text(Str.edit.toUpperCase()),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateWallet(
                    customerId: users.userId,
                    walletId: users.id.toString(),
                    accountId: '1',
                    walletBalance: users.amount,
                    type: Type.withdraw,
                  ),
                ),
              );
            },
            child: userType == Field.accountant
                ? Text(Str.withdraw.toUpperCase())
                : Text(Str.edit.toUpperCase()),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
        ),
      ],
    );
  }
}
