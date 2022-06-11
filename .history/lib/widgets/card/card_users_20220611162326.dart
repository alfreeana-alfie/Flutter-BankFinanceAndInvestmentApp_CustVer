import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/pages/admin/users_layout.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardUser extends StatelessWidget {
  const CardUser(
      {Key? key,
      this.userLoad,
      required this.users,
      required this.userList,
      required this.index,
      required this.pageTitle, 
      required this.pageType,
      this.type})
      : super(key: key);

  final Users users;
  final User? userLoad;
  final List<Users> userList;
  final int index;
  final String? type, pageType, pageTitle;

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
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  users.profilePicture ??
                                      Values.userDefaultImage),
                              // backgroundImage: AssetImage(Values.userPath),
                              minRadius: 10,
                              maxRadius: 20,
                            ),
                            const Gap(20),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 100, maxWidth: 220),
                              child: Text(
                                users.name ?? Field.emptyString,
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.ellipsis,
                              ),
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
    String branchName = '';
    if (users.userType!= Field.customer) {
      var parts = users.branchId!.split(' ');
      var prefix = parts[1].trim();
      branchName = prefix;
    }

    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(
                labelTitle: Str.userId,
                labelDetails: users.userType == Field.customer
                    ? users.id.toString()
                    : 'FVIS-$branchName-${users.id.toString()}'),
            // DetailRow(
            //     labelTitle: Str.userId, labelDetails: users.id.toString()),
            DetailRow(
                labelTitle: Str.name,
                labelDetails: users.name ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.email,
                labelDetails: users.email ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.countryCode,
                labelDetails: users.countryCode ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.phoneNumber,
                labelDetails: users.phone ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.userType,
                labelDetails: users.userType ?? Field.emptyString),
            // DetailRow(
            //     labelTitle: Str.role, labelDetails: users.roleId.toString()),
            // DetailRow(
            //     labelTitle: Str.branch,
            //     labelDetails: users.branchId.toString()),
            DetailRow(
                labelTitle: Str.status, labelDetails: users.status.toString()),
            // DetailRow(labelTitle: Str.profilePicture, labelDetails: users.profilePicture ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.emailVerifiedAt,
                labelDetails: users.emailVerifiedAt ?? Field.emptyString),
            DetailRow(
                labelTitle: Str.smsVerifiedAt,
                labelDetails: users.smsVerifiedAt ?? Field.emptyString),
            // DetailRow(
            //     labelTitle: Str.provider,
            //     labelDetails: users.provider ?? Field.emptyString),

            if (type != Type.branchStaff) _buildButtonRow(context),
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
                  builder: (context) => UsersLayout(
                    pageType: pageType,
                    pageTitle: pageTitle,
                    user: users,
                    type: Field.update,
                    userLoad: userLoad,
                    creatorType: userLoad!.userType,
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
                userList.removeAt(index);

                CustomToast.showMsg('Deleting...', Styles.dangerColor);

                Method.deleteUser(
                    context,
                    Uri.parse(
                        AdminAPI.deleteUser.toString() + users.id.toString()),
                    Type.customerAdmin,
                    UsersLayout(
                      pageType: pageType,
                    pageTitle: pageTitle,
                      type: Field.create,
                      userLoad: userLoad,
                      creatorType: userLoad!.userType!,
                    ),
                    Str.customerList,
                    Field.empty,
                    '');
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
