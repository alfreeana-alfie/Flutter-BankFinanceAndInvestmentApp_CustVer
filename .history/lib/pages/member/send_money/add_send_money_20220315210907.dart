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

  int? currentRate;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.sendMoney, implyLeading: true, context: context),
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
                        child: Text(Str.accountType,
                            style: Styles.primaryTitle),
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
                        child: Text(Str.userAccount,
                            style: Styles.primaryTitle),
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
                        child:
                            Text(Str.currency, style: Styles.primaryTitle),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        if(accountBalance != '0.00') {

                        }else {
                          CustomToast.showMsg('Insufficient funds', Styles.dangerColor);
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
