import 'dart:convert';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/send_money_methods.dart';
import 'package:flutter_banking_app/models/customer.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_user.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class MCreateSendMoney extends StatefulWidget {
  const MCreateSendMoney({Key? key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<MCreateSendMoney> {
  final ScrollController _scrollController = ScrollController();

  var controller = ScrollController();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

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

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.sendMoneyTxt, implyLeading: true, context: context),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(Str.userAccountTxt,
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
                              Text(Str.currencyTxt, style: Styles.primaryTitle),
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
                        onChanged: (val) {
                          setState(
                            () {
                              currency = val!.id.toString();
                              currencyName = val.name;
                            },
                          );
                        },
                      ),
                    ),
                    const Gap(20.0),
                    NewField(
                        onSaved: (val) => amount = val,
                        hintText: Str.descriptionTxt),
                    const Gap(10),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Styles.primaryColor,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
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
                            Field.transactionsDetails: transactionsDetails
                          };
                          SendMoneyMethods.add(context, body);
                        },
                        text: Str.sendMoneyTxt,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
