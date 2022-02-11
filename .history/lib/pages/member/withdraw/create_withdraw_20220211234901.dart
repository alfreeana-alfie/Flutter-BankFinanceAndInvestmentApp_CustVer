import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/wire_transfer_methods.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/pages/member/checkout/payment_method_send.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_account.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_bank.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:http/http.dart' as http;

class MCreateWithdraw extends StatefulWidget {
  const MCreateWithdraw({Key? key}) : super(key: key);

  @override
  _MCreateWithdrawState createState() => _MCreateWithdrawState();
}

class _MCreateWithdrawState extends State<MCreateWithdraw> {
  SharedPref sharedPref = SharedPref();
  final TextEditingController controller = TextEditingController();

  String? currency,
      currencyName,
      userId,
      userPhone,
      otherBankId,
      otherBankName,
      amount,
      note,
      swiftCode,
      accountHolder,
      accountHolderName,
      account,
      accountName,
      accountBalance,
      walletId,
      exchangeRate;

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
      branchId = '1',
      transactionsDetails = 'wire_transfer';

  String? transactionCode;

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

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    getCurrentRate();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    setState(() {
      transactionCode = Field.transactionCodeInitials + getRandomCode(6);
    });

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.wireTransfer, implyLeading: true, context: context),
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
                  NewField(
                      mandatory: true,
                      readOnly: true,
                      initialValue: transactionCode,
                      onSaved: (val) => transactionCode = val,
                      hintText: Str.transactionCode),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.bank, style: Styles.primaryTitle),
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
                    child: DropDownBank(
                      bank: otherBankId,
                      bankName: otherBankName,
                      swiftCode: controller.text,
                      onChanged: (val) {
                        setState(
                          () {
                            otherBankId = val!.id.toString();
                            otherBankName = val.name;
                            swiftCode = val.swiftCode;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20.0),
                  NewField(
                    controller: controller,
                      // initialValue: swiftCode,
                      mandatory: true,
                      onSaved: (val) => swiftCode = val,
                      hintText: Str.swiftCode),
                  const Gap(20.0),
                  NewField(
                     
                    mandatory: true,
                    onSaved: (val) => amount = val,
                    hintText: Str.amount,
                    labelText: Str.amountNum,
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
                    mandatory: true,
                    onSaved: (val) => accountHolder = val,
                    hintText: Str.accountHolder,
                  ),
                  const Gap(20.0),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => accountHolderName = val,
                    hintText: Str.accountHolderName,
                  ),
                  const Gap(20.0),
                  NewField(
                    onSaved: (val) => note = val,
                    hintText: Str.description,
                  ),
                  const Gap(20),
                  loadingButton(
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          Field.userId: userId ?? Field.empty,
                          Field.currencyId: currency ?? Field.empty,
                          Field.amount: amount ?? Field.emptyAmount,
                          Field.fee: fee,
                          Field.drCr: drCr,
                          Field.type: type,
                          Field.method: method,
                          Field.status: status,
                          Field.note: note ?? Field.emptyString,
                          Field.loanId: loanId,
                          Field.refId: refId,
                          Field.parentId: parentId,
                          Field.otherBankId: otherBankId ?? Field.empty,
                          Field.gatewayId: gatewayId,
                          Field.createdUserId: userId ?? Field.empty,
                          Field.updatedUserId: userId ?? Field.empty,
                          Field.branchId: branchId,
                          Field.transactionsDetails: transactionsDetails,
                          Field.transactionCode:
                              Field.transactionCodeInitials + getRandomCode(6)
                        };

                        WireTransferMethods.add(context, body);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodWalletMenu(
                                // toUserId: toUserId,
                                exchangeRate: exchangeRate,
                                currentRate: currentRate.toString(),
                                walletId: walletId,
                                amount: amount ?? '0.00',
                                accountId: account ?? '0',
                                method: 'wire_transfer',
                                creditDebit: 'credit',
                                walletBalance: accountBalance,
                                routePath: RouteSTR.wireTransferListM,
                                userPhone: userPhone,
                                message:
                                    'Wire Transfer You have just transferred $amount into your account. FVIS Investment '),
                          ),
                        );
                      },
                      text: Str.wireTransfer.toUpperCase())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
