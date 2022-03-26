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
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user_wallet.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:http/http.dart' as http;

// TODO: pk_test_7577b1531016880743e16f17ba818cd14a08f1d2 - PUBLIC KEY
// TODO: sk_test_faa379125c75547ae5db0b99b5f167ee052da92b - SECRET KEY

class UpdateWallet extends StatefulWidget {
  const UpdateWallet(
      {Key? key,
      this.customerId,
      this.walletId,
      this.accountId,
      this.walletBalance,
      this.type})
      : super(key: key);

  final String? customerId, walletId, accountId, walletBalance, type;

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

  String? emailMessage,
      emailMessage01,
      emailMessage02,
      emailMessage03,
      emailMessage04,
      emailMessageTo,
      emailMessageTo01,
      emailMessageTo02,
      emailMessageTo03,
      emailMessageTo04;

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
    loadSharedPrefs();
    getCurrentRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar:
          myAppBar(title: Str.withdraw, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewField(
              readOnly: true,
              initialValue: 'NGN ${widget.walletBalance}',
              hintText: Str.currentBalance,
              labelText: Str.amountNum,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewField(
              onSaved: (val) => amount = val,
              hintText: Str.amount,
              labelText: Str.amountNum,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
            ),
          ),
          const Gap(20),
          elevatedButton(
            color: Styles.secondaryColor,
            context: context,
            callback: () {
              double newAmount = double.parse(amount!);
              setState(() => newAmount *= double.parse('1.0'));

              double rateCharge = newAmount;
              setState(() =>
                  rateCharge *= (double.parse(currentRate.toString()) / 100));

              // Calculation - Amount
              double updatedAmount = newAmount;
              setState(() => updatedAmount -= rateCharge);

              // Calculation - Wallet subtract Updated Amount
              double updatedBalance = double.parse(widget.walletBalance!);
              setState(() => updatedBalance -= updatedAmount);

              emailMessage =
                  'Wire Transfer You have just transferred ${double.parse(amount!).toStringAsFixed(2)} into your account.';
              emailMessage01 =
                  'Amount: NGN ${double.parse(amount!).toStringAsFixed(2)} ';
              emailMessage02 =
                  'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
              emailMessage03 =
                  'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
              emailMessageTo = '';
              emailMessageTo01 =
                  'Amount: NGN ${double.parse(amount!).toStringAsFixed(2)} ';
              emailMessageTo02 =
                  'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
              emailMessageTo03 =
                  'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';

              Map<String, String> bodySender = {
                Field.userId: userId ?? userId ?? '0',
                Field.walletId: walletId ?? '0',
                Field.accountId: account ?? '0',
                Field.method: method,
                Field.creditDebit: method,
                Field.amount: double.parse(amount!).toStringAsFixed(2),
                Field.rateAmount: rateCharge.toStringAsFixed(2),
                Field.grandTotal: updatedAmount.toStringAsFixed(2),
                Field.paymentMethod: 'Wire Transfer',
                Field.currentRate: currentRate.toString(),
                Field.updatedBy: userId ?? '0',
                Field.currencyId: currency ?? '10',
                Field.transactionCode: transactionCode,
              };

              Map<String, String> updateWalletBodySender = {
                // Field.userId: userId ?? '3',
                // Field.accountId: accountId ?? '1',
                Field.amount: updatedBalance.toString(),
                Field.updatedBy: userId ?? '3',
              };

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PaymentMethodWalletMenu(
              //         // toUserId: toUserId,
              //         currentRate: currentRate.toString(),
              //         walletId: widget.walletId,
              //         amount: amount ?? '0.00',
              //         accountId: '1',
              //         method: widget.type,
              //         creditDebit: 'credit',
              //         walletBalance: widget.walletBalance,
              //         routePath: Type.nullable,
              //         type: Type.customer,
              //         pageName: Str.customerList,
              //         userPhone: userPhone,
              //         user: userLoad,
              //         userId: widget.customerId,
              //         exchangeRate: '1.0',
              //         currencyId: '10',
              //         currencyName: 'NGN',
              //         message:
              //             'Wallet Transaction Your account has been credited $amount. FVIS Investment '),
              //   ),
              // );
            },
            text: Str.submit.toUpperCase(),
          ),
        ],
      ),
    );
  }
}
