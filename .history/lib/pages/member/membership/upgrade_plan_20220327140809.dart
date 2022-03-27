import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_membership.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown.dart';
import 'package:flutter_banking_app/widgets/text_field.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'proceed_payment.dart';

// TODO: pk_test_7577b1531016880743e16f17ba818cd14a08f1d2 - PUBLIC KEY
// TODO: sk_test_faa379125c75547ae5db0b99b5f167ee052da92b - SECRET KEY

class MUpgradeMembershipPlan extends StatefulWidget {
  const MUpgradeMembershipPlan({Key? key}) : super(key: key);

  @override
  _MUpgradeMembershipPlanState createState() => _MUpgradeMembershipPlanState();
}

class _MUpgradeMembershipPlanState extends State<MUpgradeMembershipPlan> {
  var publicKey = 'pk_test_7577b1531016880743e16f17ba818cd14a08f1d2';
  final plugin = PaystackPlugin();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  UserMembership userMembership = UserMembership();
  List<UserMembership> planListNew = [];

  String? membershipId, membershipName, membershipFee, id;

  String? currentMembershipId, currentMembershipName;

  String? amount, note, currency, currencyName, toUserId, toUserName, userId;
  String fee = '12.50',
      drCr = 'Y',
      type = 'send_money',
      method = 'send_money',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      otherBankId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = '1';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.upgrade, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          FutureBuilder(
            future: getView(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Styles.accentColor,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewField(
                      readOnly: true,
                      initialValue: 'Not yet Subcribe any Membership Plan!',
                      onSaved: (val) => currentMembershipName = val,
                      hintText: Str.currentMembership,
                      // labelText: Str.amountNum,
                    ),
                  );
                } else {
                  if (currentMembershipName == null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewField(
                        readOnly: true,
                        initialValue: 'No Membership Plan subcribed yet!',
                        onSaved: (val) => currentMembershipName = val,
                        hintText: Str.currentMembership,
                        // labelText: Str.amountNum,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewField(
                      readOnly: true,
                      initialValue: currentMembershipName,
                      onSaved: (val) => membershipId = val,
                      hintText: Str.currentMembership,
                      // labelText: Str.amountNum,
                    ),
                  );
                }
              }
            },
          ),
          const Gap(20),
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
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.upgradeYourPlan,
                            style: Styles.primaryTitle),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      //   child: Text(
                      //     '*',
                      //     style: TextStyle(color: Styles.dangerColor),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownMembershipPlan(
                      membershipPlan: membershipId,
                      membershipName: membershipName,
                      onChanged: (val) {
                        setState(
                          () {
                            membershipId = val!.id.toString();
                            membershipName = val.planName;
                            membershipFee = val.planFee;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodsMenu(
                              id: id,
                              currentMembershipId: currentMembershipId,
                              membershipPlanId: membershipId ?? '',
                              membershipPlanName: membershipName,
                              fee: membershipFee,
                            ),
                          ),
                        );
                      },
                      text: Str.upgrade,
                    ),
                  ),
                  backButton(context),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  Future getView() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();

    Uri viewSingleUser = Uri.parse(API.userMembershipPlan.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);
    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        if (mounted) {
          final requests = UserMembership.fromJSON(req);
          id = requests.id.toString();

          currentMembershipId = requests.membershipPlanId;
          currentMembershipName = requests.planName;
        }
      }
    } else {
      print(Status.failed);
    }
  }

  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     print(_scrollController.offset);
  //   });
  //   plugin.initialize(publicKey: publicKey);
  //   super.initState();
  //   loadSharedPrefs();
  // }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        userId = user.id.toString();
      });
    } catch (e) {
      print(e);
    }
  }
}
