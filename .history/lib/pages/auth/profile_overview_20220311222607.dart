
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/pages/member/checkout/payment_method_send.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

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
  // List<Wallet> transactionList = [];

  // Future view(userId) async {
  //   // User user = User.fromJSON(await sharedPref.read(Pref.userData));
  //   // String userId = user.id.toString();
  //   Uri viewSingleUser = Uri.parse(API.userSavingsAccount.toString() + userId);
  //   final response = await http.get(viewSingleUser, headers: headers);

  //   if (response.statusCode == Status.ok) {
  //     var jsonBody = jsonDecode(response.body);
  //     if (mounted) {
  //       for (var req in jsonBody[Field.data]) {
  //         // final data = Wallet.fromMap(req);
  //         if (mounted) {
  //           wallet = Wallet.fromJSON(req);
  //         }
  //       }
  //     }
  //   } else {
  //     print(Status.failed);
  //     CustomToast.showMsg(Status.failed, Styles.dangerColor);
  //   }
  // }

  String? membershipId;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // setState(() {
    //   membershipId = Field.membershipIdInitials + getRandomCode(5);
    // });

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.profileOverview,
        implyLeading: true,
        context: context,
      ),
      body: _innerContainer(),
    );
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        userLoad = user;
        // view(userLoad.id.toString());
      }
    } catch (e) {
      print(e);
    }
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
                                    NetworkImage(userLoad.profilePicture ?? Values.userDefaultImage),
                                // backgroundImage: AssetImage(Values.userPath),
                                minRadius: 10,
                                maxRadius: 50,
                              ),
                            ),
                            const Gap(20),
                            NewField(
                                initialValue: userLoad.memberId,
                                onSaved: (val) => membershipId = val,
                                hintText: Str.membershipId),
                            const Gap(20.0),
                            NewField(
                                initialValue: userLoad.name,
                                onSaved: (val) => name = val,
                                hintText: Str.name),
                            const Gap(20.0),
                            NewField(
                                initialValue: userLoad.email,
                                onSaved: (val) => email = val,
                                hintText: Str.email),
                            const Gap(20.0),
                            NewField(
                                initialValue:
                                    '${userLoad.countryCode}-${userLoad.phone}',
                                onSaved: (val) => phone = val,
                                hintText: Str.phoneNumber),
                            const Gap(20.0),
                            // NewField(
                            //     initialValue: userLoad.branchId ?? 'Default',
                            //     onSaved: (val) => branchId = val,
                            //     hintText: Str.branch),
                            // const Gap(20.0),
                            NewField(
                                initialValue: emailVerifiedAt,
                                onSaved: (val) =>
                                    emailVerifiedAt = val ?? Field.emptyString,
                                hintText: Str.emailVerifiedAt),
                            const Gap(20.0),
                            userLoad.smsVerifiedAt == null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  Str.smsVerifiedAt,
                                  style: Styles.textStyle,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentMethodWalletMenu(
                                                // toUserId: toUserId,
                                                exchangeRate: '1',
                                                currentRate: '1',
                                                walletId: wallet.id.toString(),
                                                amount: '4156.60',
                                                accountId: wallet.accountId,
                                                method: 'sms_subcribed',
                                                creditDebit: 'credit',
                                                walletBalance: wallet.amount,
                                                routePath:
                                                    RouteSTR.profileOverview,
                                                user: userLoad,
                                                message:
                                                    'Congratulations, You have subcribed to SMS Notification. FVIS Investment '),
                                      ),
                                    );
                                  },
                                  child: Text(Str.subcribeNow),
                                  style: ElevatedButton.styleFrom(
                                      primary: Styles.secondaryColor,
                                      elevation: 0.0),
                                ),
                              ],
                            ) : 
                            NewField(
                                initialValue: userLoad.smsVerifiedAt ?? 'NO',
                                onSaved: (val) =>
                                    smsVerifiedAt = val ?? Field.emptyString,
                                hintText: Str.smsVerifiedAt),
                            const Gap(20),
                            elevatedButton(
                              color: Styles.secondaryColor,
                              context: context,
                              callback: () {},
                              text: Str.edit.toUpperCase(),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      
                    ],
                  ),
                ),
                
              ],
            );
          }
        }
      },
    );
  }
}
