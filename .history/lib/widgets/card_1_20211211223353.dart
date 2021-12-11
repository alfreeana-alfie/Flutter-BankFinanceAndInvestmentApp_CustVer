import 'package:bank_fvisng_admin/models/user.dart';
import 'package:bank_fvisng_admin/pages/users/edit_user.dart';
import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/detail.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card1 extends StatelessWidget {
  final User users;
  const Card1({Key? key, required this.users}) : super(key: key);

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
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/user.svg',
                            width: 40,
                            height: 40,
                            color: Styles.secondaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(users.name ?? 'No Name',
                              // style: GoogleFonts.roboto(
                              //   fontWeight: FontWeight.w600,
                              //   fontSize: 16,
                              //   color: Styles.textColor,
                              //   letterSpacing: 0.5,
                              // ),
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      )),
                  collapsed: Text(
                    loremIpsum,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(5))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsum,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Column(
                        children: [
                          Expandable(
                            collapsed: buildCollapsed1(),
                            expanded: buildExpanded1(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCollapsed1() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   "View Detail(s)",
                // ),
              ],
            ),
          ),
        ]);
  }

  buildExpanded1(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DetailRow(
                    labelTitle: Str.emailTxt, labelDetails: users.email ?? '-'),
                DetailRow(
                    labelTitle: Str.phoneNumberTxt,
                    labelDetails: users.phone ?? '-'),
                DetailRow(
                    labelTitle: Str.branchTxt,
                    labelDetails: users.branch ?? '-'),
                DetailRow(
                    labelTitle: Str.statusTxt,
                    labelDetails: users.status ?? '-'),
                DetailRow(
                    labelTitle: UserSTR.emailVerifiedTxt,
                    labelDetails: users.email_verified ?? '-'),
                DetailRow(
                    labelTitle: UserSTR.smsVerifiedTxt,
                    labelDetails: users.sms_verified ?? '-'),
                _buildButtonRow(context),
              ],
            ),
          ),
        ]);
  }

  _buildButtonRow(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditUserPage(
                      user: users,
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
          SizedBox(
            width: 25,
          ),
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
      ),
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
