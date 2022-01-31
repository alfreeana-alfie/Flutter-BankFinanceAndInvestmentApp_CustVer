import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/pages/member/checkout/payment_method_send.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({Key? key}) : super(key: key);

  @override
  _ProfileOverviewState createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  Wallet wallet = Wallet();

  String? name, email, phone, branchId, emailVerifiedAt, smsVerifiedAt;
  List<Wallet> transactionList = [];

  Future view(userId) async {
    // User user = User.fromJSON(await sharedPref.read(Pref.userData));
    // String userId = user.id.toString();
    Uri viewSingleUser = Uri.parse(API.userSavingsAccount.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      if (mounted) {
        wallet = Wallet.fromJSON(jsonBody);
      }
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        userLoad = user;
        view(userLoad.id);
      }
    } catch (e) {
      print(e);
    }
  }

  String? membershipId;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    setState(() {
      membershipId = Field.membershipIdInitials + getRandomCode(5);
    });

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.profileOverviewTxt,
        implyLeading: true,
        context: context,
      ),
      body: _innerContainer(),
    );
  }

  _innerContainer() {
    return FutureBuilder(
      future: loadSharedPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Styles.accentColor,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            DateTime emailtempDate = DateTime.parse(
                userLoad.emailVerifiedAt ?? '2019-08-29 21:19:28');
            String emailVerifiedAt =
                DateFormat('yyyy-MM-dd hh:mm:ss').format(emailtempDate);

            // DateTime smstempDate =
            //     DateTime.parse(userLoad.smsVerifiedAt ?? '-');
            // String smsVerifiedAt =
            //     DateFormat('yyyy-MM-dd hh:mm:ss').format(smstempDate);

            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Styles.cardColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              constraints: const BoxConstraints(
                                  minWidth: 20, maxWidth: 100),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(Values.userDefaultImage),
                                // backgroundImage: AssetImage(Values.userPath),
                                minRadius: 10,
                                maxRadius: 50,
                              ),
                            ),
                            const Gap(20),
                            NewField(
                                initialValue: membershipId,
                                onSaved: (val) => membershipId = val,
                                hintText: Str.membershipIdTxt),
                            const Gap(20.0),
                            NewField(
                                initialValue: userLoad.name,
                                onSaved: (val) => name = val,
                                hintText: Str.nameTxt),
                            const Gap(20.0),
                            NewField(
                                initialValue: userLoad.email,
                                onSaved: (val) => email = val,
                                hintText: Str.emailTxt),
                            const Gap(20.0),
                            NewField(
                                initialValue:
                                    '${userLoad.countryCode}-${userLoad.phone}',
                                onSaved: (val) => phone = val,
                                hintText: Str.phoneNumberTxt),
                            const Gap(20.0),
                            NewField(
                                initialValue: userLoad.branchId ?? 'Default',
                                onSaved: (val) => branchId = val,
                                hintText: Str.branchTxt),
                            const Gap(20.0),
                            NewField(
                                initialValue: emailVerifiedAt,
                                onSaved: (val) =>
                                    emailVerifiedAt = val ?? Field.emptyString,
                                hintText: Str.emailVerifiedAtTxt),
                            const Gap(20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  Str.smsVerifiedAtTxt,
                                  style: Styles.textStyle,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print(wallet.id);
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         PaymentMethodWalletMenu(
                                    //             // toUserId: toUserId,
                                    //             exchangeRate: '1',
                                    //             currentRate: '1',
                                    //             walletId: '1',
                                    //             amount: '10',
                                    //             accountId: account ?? '0',
                                    //             method: 'wire_transfer',
                                    //             creditDebit: 'credit',
                                    //             walletBalance: accountBalance,
                                    //             routePath:
                                    //                 RouteSTR.profileOverview,
                                    //             user: userLoad,
                                    //             message:
                                    //                 'Congralations, You have subcribed to SMS Notification. FVIS Investment '),
                                    //   ),
                                    // );
                                  },
                                  child: Text(Str.subcribeNowTxt),
                                  style: ElevatedButton.styleFrom(
                                      primary: Styles.secondaryColor,
                                      elevation: 0.0),
                                ),
                              ],
                            ),
                            // NewField(
                            //     initialValue: userLoad.smsVerifiedAt ?? 'NO',
                            //     onSaved: (val) =>
                            //         smsVerifiedAt = val ?? Field.emptyString,
                            //     hintText: Str.smsVerifiedAtTxt),
                            const Gap(20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Gap(20),
                // elevatedButton(
                //   color: Styles.secondaryColor,
                //   context: context,
                //   callback: () {},
                //   text: Str.saveTxt.toUpperCase(),
                // ),
              ],
            );
          }
        }
      },
    );
  }
}
