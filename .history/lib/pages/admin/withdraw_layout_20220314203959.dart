import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/withdraw_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_bank.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_branches.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_currency.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WithdrawLayout extends StatefulWidget {
  const WithdrawLayout(
      {Key? key,
      this.customerId,
      this.walletId,
      this.accountId,
      this.walletBalance,
      this.currentRate,
      this.exchangeRate})
      : super(key: key);

  final String? customerId,
      walletId,
      accountId,
      walletBalance,
      currentRate,
      exchangeRate;

  @override
  _WithdrawLayoutState createState() => _WithdrawLayoutState();
}

class _WithdrawLayoutState extends State<WithdrawLayout> {
  SharedPref sharedPref = SharedPref();
  final TextEditingController controller = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? currency,
      currencyName,
      userId,
      userPhone,
      otherBankId,
      otherBankName,
      amount,
      note,
      swiftCode,
      accountHolderPhoneNo,
      accountHolderName,
      accountNo,
      account,
      accountName,
      accountBalance,
      walletId,
      branchId,
      branchName,
      exchangeRate;

  String? bank, branch, purpose;

  String fee = '1',
      drCr = '1',
      type = '1',
      method = 'wire_transfer',
      status = '1',
      loanId = '1',
      refId = '1',
      parentId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      transactionsDetails = 'wire_transfer';

  String? transactionCode;

  String? currentRate;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    setState(() {
      transactionCode = Field.transactionCodeInitials + getRandomCode(6);
    });

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar:
          myAppBar(title: Str.withdraw, implyLeading: true, context: context),
      body: ListView(
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
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // NewField(
                  //     mandatory: true,
                  //     readOnly: true,
                  //     initialValue: transactionCode,
                  //     onSaved: (val) => transactionCode = val,
                  //     hintText: Str.transactionCode),
                  // const Gap(20),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(Str.bank, style: Styles.primaryTitle),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(
                  //         '*',
                  //         style: TextStyle(color: Styles.dangerColor),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   child: DropDownBank(
                  //     bank: otherBankId,
                  //     bankName: otherBankName,
                  //     swiftCode: swiftCode,
                  //     onChanged: (val) {
                  //       setState(
                  //         () {
                  //           otherBankId = val!.id.toString();
                  //           otherBankName = val.name;
                  //           swiftCode = val.swiftCode;
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  NewField(
                      initialValue: bank,
                      mandatory: true,
                      onSaved: (val) => bank = val,
                      hintText: Str.bank),
                  const Gap(20.0),
                  NewField(
                      initialValue: branch,
                      mandatory: true,
                      onSaved: (val) => branch = val,
                      hintText: Str.branch),
                  const Gap(20.0),
                  // NewField(
                  //   controller: controller,
                  //     // initialValue: swiftCode,
                  //     mandatory: true,
                  //     onSaved: (val) => swiftCode = val,
                  //     hintText: Str.swiftCode),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(Str.branch, style: Styles.primaryTitle),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                  //       child: Text(
                  //         '*',
                  //         style: TextStyle(color: Styles.dangerColor),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   child: DropDownBranches(
                  //     branch: branchId,
                  //     branchName: branchName,
                  //     onChanged: (val) {
                  //       setState(
                  //         () {
                  //           branchId = val!.id.toString();
                  //           branchName = val.name;
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  // const Gap(20.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.currency, style: Styles.primaryTitle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(
                          '*',
                          style: TextStyle(color: Styles.dangerColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownCurrency(
                      currency: currency,
                      currencyName: currencyName,
                      currencyExchangeRate: exchangeRate,
                      onChanged: (val) {
                        setState(
                          () {
                            currency = val!.id.toString();
                            currencyName = val.name;
                            exchangeRate = val.exchangeRate;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => amount = val,
                    hintText: Str.amount,
                    labelText: Str.amountNum,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                  // const Gap(20.0),
                  // NewField(
                  //   mandatory: true,
                  //   onSaved: (val) => accountHolderName = val,
                  //   hintText: Str.accountHolderName,
                  //   textInputAction: TextInputAction.next,
                  //   textInputType: TextInputType.text,
                  // ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => accountNo = val,
                    hintText: Str.accountNo,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                  const Gap(20.0),
                  NewField(
                      onSaved: (val) => purpose = val,
                      hintText: Str.purpose,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text),
                  const Gap(20),
                  RoundedLoadingButton(
                    elevation: 0.0,
                    borderRadius: 15,
                    width: double.maxFinite,
                    color: Styles.secondaryColor,
                    controller: _btnController,
                    onPressed: () {
                      Map<String, String> body = {
                        Field.userId: widget.customerId ?? Field.emptyInt,
                        Field.bankName: bank ?? Field.emptyInt,
                        Field.branchName: branch ?? Field.emptyString,
                        Field.swiftCode: swiftCode ?? Field.emptyInt,
                        Field.accountHolderName:
                            accountHolderName ?? Field.emptyInt,
                        Field.accountNo: accountNo ?? Field.emptyInt,
                        Field.currency: currency ?? Field.emptyInt,
                        Field.accountHolderPhoneNo:
                            accountHolderPhoneNo ?? Field.emptyInt,
                        Field.amount: amount ?? Field.emptyAmount,
                        Field.purpose: purpose ?? Field.emptyString,
                        Field.transactionCode: Field.transactionCodeInitials +
                            '$currencyName-' +
                            getRandomCode(6)
                      };

                      // WithdrawMethods.add(context, body);

                      double rateCharge = double.parse(amount!);
                      setState(() => rateCharge *=
                          (double.parse(currentRate!) / 100));

                      // Calculation - Amount
                      double updatedAmount = double.parse(amount!);
                      setState(() => updatedAmount -= rateCharge);

                      double updatedBalance =
                          double.parse(widget.walletBalance!);
                      if (method == Type.deposit || method == Type.topUp) {
                        setState(() => updatedBalance += updatedAmount);
                      } else {
                        setState(() => updatedBalance -= updatedAmount);
                      }

                      // Calculation - Rate
                      if (exchangeRate != null) {
                        double newAmount = double.parse(amount!);
                        setState(() =>
                            newAmount *= double.parse(exchangeRate!));

                        double rateCharge = newAmount;
                        setState(() => rateCharge *=
                            (double.parse(currentRate!) / 100));

                        // Calculation - Amount
                        double updatedAmount = newAmount;
                        setState(() => updatedAmount -= rateCharge);

                        // Calculation - Wallet subtract Updated Amount
                        double updatedBalance =
                            double.parse(widget.walletBalance!);
                        if (method == Type.deposit || method == Type.topUp) {
                          setState(() => updatedBalance += updatedAmount);
                        } else {
                          setState(() => updatedBalance -= updatedAmount);
                        }
                      }

                      print(updatedBalance);

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => PaymentMethodWalletMenu(
                      //         // toUserId: toUserId,
                      //         exchangeRate: exchangeRate,
                      //         currentRate: currentRate.toString(),
                      //         walletId: walletId,
                      //         amount: amount ?? '0.00',
                      //         accountId: account ?? '0',
                      //         method: 'withdraw',
                      //         creditDebit: 'credit',
                      //         walletBalance: accountBalance,
                      //         routePath: RouteSTR.createWithdraw,
                      //         // routePath: Type.nullable,
                      //         type: Type.withdraw,
                      //         pageName: Str.withdrawList,
                      //         userPhone: userPhone,
                      //         message:
                      //             'Withdraw You have just withdraw $amount from your account. FVIS Investment '),
                      //   ),
                      // );
                    },
                    child: Text(
                      Str.submit.toUpperCase(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: backButton(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  @override
  void initState() {
    loadSharedPrefs();
    getCurrentRate();
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userId = user.id.toString();
        userPhone = user.phone;
      });
    } catch (e) {
      print(e);
    }
  }
}
