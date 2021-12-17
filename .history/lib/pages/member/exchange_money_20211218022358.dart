import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/exchange_money.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdrown_currency.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class ExchangeMoney extends StatefulWidget {
  const ExchangeMoney({Key? key}) : super(key: key);

  @override
  _ExchangeMoneyState createState() => _ExchangeMoneyState();
}

class _ExchangeMoneyState extends State<ExchangeMoney> {
  final ScrollController _scrollController = ScrollController();

  String? exchangeFrom, exchangeTo, amount, note;

  String 
      currencyId = '1',
      fee = '1',
      drCr = '1',
      type = '1',
      method = 'wire_transfer',
      status = 'wire_transfer',
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

  void getCurrency() async {
    final response = await http.get(API.listOfCurrency, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      // var jsonData = Currency.fromMap(jsonBody);

      for (var currency in jsonBody['data']) {
        final currencies = Currency.fromMap(currency);

        setState(() {
          currencyListNew.add(currencies);
        });
      }

      // print(jsonData.name);
    } else {
      print(Status.failedTxt);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.exchangeMoneyTxt, implyLeading: true, context: context),
      bottomSheet: Container(
        color: Styles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: elevatedButton(
          color: Styles.secondaryColor,
          context: context,
          callback: () {
            print(exchangeFrom);
            print(exchangeTo);
            // Map<String, String> body = {
            //   Field.userId: userId,
            //   Field.currencyId: currencyId,
            //   Field.amount: amount,
            //   Field.fee: fee,
            //   Field.drCr: drCr,
            //   Field.type: type,
            //   Field.method: method,
            //   Field.status: status,
            //   Field.note: note,
            //   Field.loanId: loanId,
            //   Field.refId: refId,
            //   Field.parentId: parentId,
            //   Field.otherBankId: otherBankId,
            //   Field.gatewayId: gatewayId,
            //   Field.createdUserId: createdUserId,
            //   Field.updatedUserId: updatedUserId,
            //   Field.branchId: branchId,
            //   Field.transactionsDetails: transactionsDetails
            // };

            // ExchangeMoneyMethods.add(context, body);
          },
          text: Str.exchangeMoneyTxt.toUpperCase(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Styles.primaryWithOpacityColor,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropDownCurrency(
                            currency: exchangeFrom,
                            onChanged: (val) {
                              setState(
                                () {
                                  exchangeFrom = val;
                                },
                              );
                            },
                          ),
                          const Gap(20.0),
                          Center(
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: const Text('TO',
                                    style: Styles.subtitleStyle02)),
                          ),
                          const Gap(20.0),
                          DropDownCurrency(
                            currency: exchangeTo,
                            onChanged: (val) {
                              setState(
                                () {
                                  exchangeTo = val;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(20.0),
                      TextFormField(
                        readOnly: true,
                        onChanged: (val) {
                          amount = val;
                        },
                        style: Styles.subtitleStyle,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: Str.amountTxt,
                          labelStyle: Styles.subtitleStyle,
                          hintText: Str.amountNumTxt,
                          hintStyle: Styles.subtitleStyle03,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15)),
                    color: Styles.yellowColor,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    onChanged: (val) {
                      note = val;
                    },
                    style: Styles.subtitleStyleDark,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: Str.descriptionTxt,
                      labelStyle: Styles.subtitleStyleDark02,
                      hintText: Str.descriptionTxt,
                      hintStyle: Styles.subtitleStyleDark03,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 0.0,
                      ),
                    ),
                  ),
                ),
                // const Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
