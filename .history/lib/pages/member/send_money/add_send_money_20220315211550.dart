import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/send_money_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/pages/member/checkout/payment_method_send.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_account.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_currency.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class MCreateSendMoney extends StatefulWidget {
  const MCreateSendMoney({Key? key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<MCreateSendMoney> {
  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  String? amount,
      note,
      currency,
      currencyName,
      exchangeRate,
      toUserId,
      toUserName,
      userId,
      userPhone,
      userName,
      account,
      accountName,
      accountBalance,
      walletId;
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

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar:
          myAppBar(title: Str.sendMoney, implyLeading: true, context: context),
      body: Container(
        margin: const EdgeInsets.all(15),
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
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.accountType, style: Styles.primaryTitle),
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
                    child: DropDownAccount(
                      walletId: walletId,
                      account: account,
                      accountName: accountName,
                      accountBalance: accountBalance,
                      onChanged: (val) {
                        setState(
                          () {
                            walletId = val!.id.toString();
                            account = val.accountId.toString();
                            accountName = val.description ?? 'DEFAULT';
                            accountBalance = val.amount ?? '0.00';
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.userAccount, style: Styles.primaryTitle),
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
                    child: DropDownUser(
                      users: toUserId,
                      usersName: toUserName,
                      onChanged: (val) {
                        setState(
                          () {
                            toUserId = val!.id.toString();
                            toUserName = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20.0),
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
                    onSaved: (val) => amount = val,
                    hintText: Str.amount,
                    labelText: Str.amountNum,
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        if (accountBalance != '0.00') {
                          Map<String, String> body = {
                            Field.userId: userId ?? Field.emptyString,
                            Field.currencyId: currency ?? '-',
                            Field.amount: amount ?? '0.00',
                            Field.fee: fee,
                            Field.drCr: drCr,
                            Field.type: type,
                            Field.method: method,
                            Field.status: status,
                            Field.note: note ?? '-',
                            Field.loanId: loanId,
                            Field.refId: refId,
                            Field.parentId: parentId,
                            Field.otherBankId: otherBankId,
                            Field.gatewayId: gatewayId,
                            Field.createdUserId: toUserId ?? '-',
                            Field.updatedUserId: updatedUserId,
                            Field.branchId: branchId,
                            Field.transactionsDetails: transactionsDetails,
                            Field.transactionCode:
                                Field.transactionCodeInitials +
                                    '$currencyName-' +
                                    getRandomCode(6)
                          };
                          SendMoneyMethods.add(context, body);

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => PaymentMethodWalletMenu(
                          //         exchangeRate: exchangeRate,
                          //         currentRate: currentRate.toString(),
                          //         toUserId: toUserId,
                          //         walletId: walletId,
                          //         amount: amount ?? '0.00',
                          //         accountId: account ?? '0',
                          //         method: 'send_money',
                          //         creditDebit: 'credit',
                          //         walletBalance: accountBalance,
                          //         routePath: RouteSTR.sendMoneyListM,
                          //         userPhone: userPhone,
                          //         user: userLoad,
                          //         currencyId: currency,
                          //         currencyName: currencyName,
                          //         messageTo:
                          //             'Send Money You have just received $amount from $userName. FVIS Investment ',
                          //         message:
                          //             'Send Money You have just send $amount to $toUserName. FVIS Investment '),
                          //   ),
                          // );
                          if (exchangeRate != null) {
                            double newAmount = double.parse(amount!);
                            setState(
                                () => newAmount *= double.parse(exchangeRate!));

                            double rateCharge = newAmount;
                            setState(() => rateCharge *=
                                (double.parse(currentRate.toString()) / 100));

                            // Calculation - Amount
                            double updatedAmount = newAmount;
                            setState(() => updatedAmount -= rateCharge);

                            // Calculation - Wallet subtract Updated Amount
                            double updatedBalance =
                                double.parse(walletBalance!);
                            if (method == Type.deposit ||
                                method == Type.topUp) {
                              setState(() => updatedBalance += updatedAmount);
                            } else {
                              setState(() => updatedBalance -= updatedAmount);
                            }
                          }

                          emailMessage =
                              'Send Money You have just send ${double.parse(amount!).toStringAsFixed(2)} to $toUserName.';
                          emailMessage01 =
                              'Amount: NGN ${double.parse(amount!).toStringAsFixed(2)} ';
                          emailMessage02 =
                              'Current Rate Charge: NGN ${current.toStringAsFixed(2)} ';
                          emailMessage03 =
                              'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';
                          emailMessageTo =
                              'Send Money You have just received ${double.parse(amount!).toStringAsFixed(2)} from $userName.';
                          emailMessageTo01 =
                              'Amount: NGN ${double.parse(amount).toStringAsFixed(2)} ';
                          emailMessageTo02 =
                              'Current Rate Charge: NGN ${rateCharge.toStringAsFixed(2)} ';
                          emailMessageTo03 =
                              'Total Amount: NGN ${updatedAmount.toStringAsFixed(2)}';

                          Map<String, String> body = {
                            Field.userId: widget.userId ?? userId ?? '0',
                            Field.walletId: walletId ?? '0',
                            Field.accountId: accountId ?? '0',
                            Field.method: method ?? 'default',
                            Field.creditDebit: method ?? 'default',
                            Field.amount:
                                double.parse(amount).toStringAsFixed(2),
                            Field.rateAmount: rateCharge.toStringAsFixed(2),
                            Field.grandTotal: updatedAmount.toStringAsFixed(2),
                            Field.paymentMethod: paymentMethod,
                            Field.currentRate: widget.currentRate ?? '0',
                            Field.updatedBy: userId ?? '0',
                            Field.currencyId: widget.currencyId ?? '10',
                            Field.transactionCode: Field.transactionCode +
                                '${widget.currencyName}-' +
                                getRandomString(6),
                          };

                          Map<String, String> toUserBody = {
                            Field.userId: toUserId ?? '0',
                            Field.walletId: walletId ?? '0',
                            Field.accountId: '1' ?? '0',
                            Field.method: method ?? 'default',
                            Field.creditDebit: method ?? 'default',
                            Field.amount:
                                double.parse(amount).toStringAsFixed(2),
                            Field.rateAmount: rateCharge.toStringAsFixed(2),
                            Field.grandTotal: updatedAmount.toStringAsFixed(2),
                            Field.paymentMethod: paymentMethod,
                            Field.updatedBy: toUserId ?? '0',
                            Field.currencyId: widget.currencyId ?? '10',
                            Field.transactionCode: Field.transactionCode +
                                '${widget.currencyName}-' +
                                getRandomString(6),
                          };

                          Map<String, String> updateWalletBody = {
                            // Field.userId: userId ?? '3',
                            // Field.accountId: accountId ?? '1',
                            Field.amount: updatedBalance.toString(),
                            Field.updatedBy: userId ?? '3',
                          };

                          WalletMethods.addTransaction(context, body);
                          WalletMethods.update(context, updateWalletBody,
                              widget.walletId ?? '0');

                          if (method == 'sms_subcribed') {
                            updateSMS(context, userLoad.id.toString());
                          }

                          if (toUserId != null) {
                            if (userLoad.emailVerifiedAt != null) {
                              EmailJS.send(
                                  context,
                                  userLoad.email ?? 'customer@gmail.com',
                                  userLoad.name ?? 'user',
                                  'FVIS Investment',
                                  emailMessage ?? 'Default',
                                  emailMessage01 ?? 'Default',
                                  emailMessage02 ?? 'Default',
                                  emailMessage03 ?? 'Default');
                              EmailJS.send(
                                  context,
                                  toUserEmail ?? 'customer@gmail.com',
                                  toUserName ?? 'user',
                                  'FVIS Investment',
                                  emailMessage ?? 'Default',
                                  emailMessageTo01 ?? 'Default',
                                  emailMessageTo02 ?? 'Default',
                                  emailMessageTo03 ?? 'Default');
                            } else if (userLoad.smsVerifiedAt != null) {
                              SMSNigeriaAPI.send(context, userPhone ?? '000',
                                  message ?? 'default');
                              SMSNigeriaAPI.send(context, toUserId ?? '000',
                                  messageTo ?? 'default');
                            }

                            WalletMethods.addTransaction(context, toUserBody);
                            WalletMethods.update(context, updateWalletBody,
                                widget.walletId ?? '2');

                            Future.delayed(const Duration(milliseconds: 2000),
                                () {
                              // Navigator.pushReplacementNamed(context, routePath!);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CardList(
                                    userType: userLoad.userType,
                                    type: type,
                                    routePath: routePath,
                                    pageName: pageName,
                                  ),
                                ),
                              );
                            });
                          }
                        } else {
                          CustomToast.showMsg(
                              'Insufficient funds', Styles.dangerColor);
                        }
                      },
                      text: Str.submit.toUpperCase(),
                    ),
                  ),
                  backButton(context),
                ],
              ),
            ),
          ],
        ),
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
        userLoad = user;

        userId = user.id.toString();
        userPhone = user.phone;
        userName = user.name;
      });
    } catch (e) {
      print(e);
    }
  }
}
