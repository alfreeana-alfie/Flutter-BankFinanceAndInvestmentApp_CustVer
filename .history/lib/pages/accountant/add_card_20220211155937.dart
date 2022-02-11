import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_membership.dart';
import 'package:flutter_banking_app/pages/member/checkout/payment_method_send.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:http/http.dart' as http;

// TODO: pk_test_7577b1531016880743e16f17ba818cd14a08f1d2 - PUBLIC KEY
// TODO: sk_test_faa379125c75547ae5db0b99b5f167ee052da92b - SECRET KEY

class UpdateWallet extends StatefulWidget {
  const UpdateWallet(
      {Key? key,this.customerId,  this.walletId, this.accountId, this.walletBalance})
      : super(key: key);

  final String? walletId, accountId, walletBalance;

  @override
  _UpdateWalletState createState() => _UpdateWalletState();
}

class _UpdateWalletState extends State<UpdateWallet> {
  var publicKey = 'pk_test_7577b1531016880743e16f17ba818cd14a08f1d2';
  final plugin = PaystackPlugin();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  UserMembership userMembership = UserMembership();
  List<UserMembership> planListNew = [];

  String? membershipId, membershipName, membershipFee, id;

  String? currentMembershipId, currentMembershipName;

  String? amount,
      note,
      currency,
      currencyName,
      toUserId,
      toUserName,
      userId,
      userPhone;
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

  int? currentRate;

  Future getCurrentRate() async {
    Uri viewSingleUser =
        Uri.parse(API.getCurrentRateByFunctionName.toString() + method);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      setState(() {
        currentRate = jsonDecode(response.body);
      });
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        userId = user.id.toString();
        userPhone = user.phone;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    getCurrentRate();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.topUpWallet, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewField(
              onSaved: (val) => amount = val,
              hintText: Str.amount,
              labelText: Str.amountNum,
            ),
          ),
          const Gap(20),
          elevatedButton(
            color: Styles.secondaryColor,
            context: context,
            callback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentMethodWalletMenu(
                      // toUserId: toUserId,
                      currentRate: currentRate.toString(),
                      walletId: widget.walletId,
                      amount: amount ?? '0.00',
                      accountId: widget.accountId ?? '0',
                      method: 'top_up',
                      creditDebit: 'debit',
                      walletBalance: widget.walletBalance,
                      routePath: RouteSTR.walletListM,
                      userPhone: userPhone,
                      user: userLoad, 
                      message:
                          'Top-Up Wallet You have just top-up $amount into your account. FVIS Investment '),
                ),
              );
            },
            text: Str.submit,
          ),
        ],
      ),
    );
  }
}
