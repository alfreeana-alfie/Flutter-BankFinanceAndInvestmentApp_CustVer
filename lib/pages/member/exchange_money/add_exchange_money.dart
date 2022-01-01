import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/methods/member/exchange_money_methods.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class MCreateExchangeMoney extends StatefulWidget {
  const MCreateExchangeMoney({Key? key}) : super(key: key);

  @override
  _ExchangeMoneyState createState() => _ExchangeMoneyState();
}

class _ExchangeMoneyState extends State<MCreateExchangeMoney> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  final ScrollController _scrollController = ScrollController();

  String? exchangeFrom,
      exchangeFromName,
      exchangeTo,
      exchangeToName,
      amount,
      note,
      userId;

  String currencyId = '1',
      fee = '1',
      drCr = '1',
      type = '1',
      method = 'exchange_money',
      status = 'exchange_money',
      loanId = '1',
      refId = '1',
      parentId = '1',
      otherBankId = '1',
      gatewayId = '1',
      createdUserId = '1',
      updatedUserId = '1',
      branchId = '1',
      transactionsDetails = '1';

  List<Currency> currencyListNew = [];

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
        bottomSheet: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                color: Styles.greyColor,
              ),
              // color: Styles.primaryColor,
              margin: const   EdgeInsets.fromLTRB(15,0,15,15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    Field.userId: userId ?? '0',
                    Field.currencyId: exchangeTo ?? Field.emptyString,
                    Field.amount: amount ?? '0.00',
                    Field.fee: fee,
                    Field.drCr: drCr,
                    Field.type: type,
                    Field.method: method,
                    Field.status: Status.pending.toString(),
                    Field.note: note ?? '-',
                    Field.loanId: loanId,
                    Field.refId: refId,
                    Field.parentId: parentId,
                    Field.otherBankId: otherBankId,
                    Field.gatewayId: gatewayId,
                    Field.createdUserId: userId ?? Field.emptyString,
                    Field.updatedUserId: userId ?? Field.emptyString,
                    Field.branchId: branchId,
                    Field.transactionsDetails: note ?? '-'
                  };

                  ExchangeMoneyMethods.add(context, body);
                },
                text: Str.exchangeMoneyTxt.toUpperCase(),
              ),
            ),
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.exchangeMoneyTxt, implyLeading: true, context: context),
        body: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Styles.greyColor,
          ),
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DropDownCurrency(
                                currency: exchangeFrom,
                                currencyName: exchangeFromName,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      exchangeFrom = val!.id.toString();
                                      exchangeFromName = val.name;
                                    },
                                  );
                                },
                              ),
                              const Gap(20.0),
                              const Center(
                                child: Text('TO', style: Styles.primaryTitle),
                              ),
                              const Gap(20.0),
                              DropDownCurrency(
                                currency: exchangeTo,
                                currencyName: exchangeToName,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      exchangeTo = val!.id.toString();
                                      exchangeToName = val.name;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const Gap(20.0),
                          NewField(
                            onSaved: (val) => amount = val,
                            hintText: Str.amountTxt,
                            labelText: Str.amountNumTxt,
                          ),
                          // TextFormField(
                          //   onChanged: (val) {
                          //     amount = val;
                          //   },
                          //   style: Styles.subtitleStyle,
                          //   textInputAction: TextInputAction.done,
                          //   keyboardType: TextInputType.text,
                          //   maxLines: 1,
                          //   decoration: InputDecoration(
                          //     labelText: Str.amountTxt,
                          //     labelStyle: Styles.subtitleStyle,
                          //     hintText: Str.amountNumTxt,
                          //     hintStyle: Styles.subtitleStyle03,
                          //     border: const OutlineInputBorder(
                          //       borderSide: BorderSide.none,
                          //       gapPadding: 0.0,
                          //     ),
                          //   ),
                          // ),
                          NewField(
                              onSaved: (val) => note = val,
                              hintText: Str.noteTxt),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
